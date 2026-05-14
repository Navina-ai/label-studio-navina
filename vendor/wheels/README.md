# Vendored Python wheels

This directory holds prebuilt wheels for upstream Python dependencies that
cannot be installed directly from their canonical source.

## `label_studio_sdk-1.0.6-py3-none-any.whl`

Built from the HumanSignal/label-studio-sdk repository at commit
`ed511ac4771775cc7b5081a412a7bfd170d37d66`.

Why this wheel exists instead of pinning the source archive directly:

- The SDK's `pyproject.toml` at this commit declares `[tool.poetry]` for
  metadata but also includes a `[project.urls]` section. Modern
  `poetry-core` (>=2) interprets the presence of any `[project.*]`
  table as PEP 621 mode and rejects the file with:

      RuntimeError: The Poetry configuration is invalid:
        - project must contain ['name'] properties

  during `poetry install` build isolation.
- Bumping the SDK to PyPI is not safe: 1.0.18 is API-incompatible with
  this codebase (`label_studio.tasks.models.format_results` KeyErrors on
  `from_name`) and breaks Python 3.9 (`projects/exports/client_ext.py`
  uses PEP 604 unions evaluated at class-body time).
- `PIP_CONSTRAINT` does not propagate into Poetry's chef build
  environment, so constraining `poetry-core<2` at the workflow level
  has no effect.

## Rebuilding

```sh
TMPDIR=$(mktemp -d)
curl -sL https://github.com/HumanSignal/label-studio-sdk/archive/ed511ac4771775cc7b5081a412a7bfd170d37d66.zip -o "$TMPDIR/sdk.zip"
unzip -q "$TMPDIR/sdk.zip" -d "$TMPDIR"
echo 'poetry-core<2' > "$TMPDIR/build-constraints.txt"
PIP_CONSTRAINT="$TMPDIR/build-constraints.txt" \
  python3.10 -m pip wheel --no-deps "$TMPDIR/label-studio-sdk-ed511ac4771775cc7b5081a412a7bfd170d37d66" -w vendor/wheels
```

The resulting wheel filename and content hash should match the entry
recorded in `poetry.lock` for `label-studio-sdk`.
