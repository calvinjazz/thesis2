from django.db import models

# Create your models here.
class Feature(models.Model):
    name = models.CharField(max_length=20)
    details = models.CharField(max_length=200)
