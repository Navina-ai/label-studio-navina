class TaskMixin:
    def has_permission(self, user: 'User') -> bool:  # noqa: F821
        """Called by Task#has_permission"""
        return True

    def _get_is_labeled_value(self) -> bool:
        # check if task is labeled by the number of completed annotations and has conflicts
        n = self.completed_annotations.count()
        has_conflicts = self.calc_conflict_status()
        return (n >= self.overlap) and not has_conflicts

    def update_is_labeled(self, *args, **kwargs) -> None:
        self.is_labeled = self._get_is_labeled_value()

    @classmethod
    def post_process_bulk_update_stats(cls, tasks) -> None:
        pass

    def before_delete_actions(self):
        """
        Actions to execute before task deletion
        """
        pass

    @staticmethod
    def after_bulk_delete_actions(tasks_ids):
        """
        Actions to execute after bulk task deletion
        """
        pass


class AnnotationMixin:
    def has_permission(self, user: 'User') -> bool:  # noqa: F821
        """Called by Annotation#has_permission"""
        return True
