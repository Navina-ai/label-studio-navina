# Generated by Django 3.2.25 on 2024-08-14 10:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tasks', '0048_auto_20240711_1338'),
    ]

    operations = [
        migrations.AddIndex(
            model_name='task',
            index=models.Index(fields=['project', 'total_annotations'], name='task_project_69db22_idx'),
        ),
        migrations.AddIndex(
            model_name='task',
            index=models.Index(fields=['project', 'cancelled_annotations'], name='task_project_1daa44_idx'),
        ),
    ]
