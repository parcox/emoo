# Generated by Django 3.1.4 on 2021-06-25 13:16

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('emodul', '0003_emodulcomment'),
    ]

    operations = [
        migrations.AddField(
            model_name='emodul',
            name='tanggal',
            field=models.DateField(auto_now=True),
        ),
        migrations.AlterField(
            model_name='emodul',
            name='penulis',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='emodul', to=settings.AUTH_USER_MODEL, verbose_name='Uploader'),
        ),
    ]