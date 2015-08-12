from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User
from django.core.urlresolvers import reverse

# Create your models here.
class Category(models.Model):
	title = models.CharField(max_length=255)
	slug = models.SlugField(unique=True)
	description = models.CharField(max_length=255, null=True, default='')

	def __str__(self):
		return self.title

class Post(models.Model):
	author = models.ForeignKey(User, blank=True, null=True)

	title = models.CharField(max_length=200)
	subtitle = models.CharField(max_length=200, blank=True)
	body = models.TextField()

	slug = models.SlugField(unique=True)
	categories = models.ManyToManyField(Category, blank=True)

	# post dates
	created_date = models.DateTimeField(
			default=timezone.now)
	published_date = models.DateTimeField(
			blank=True, null=True)

	def publish(self):
		self.published_date = timezone.now()
		self.save()

	def __str__(self):
		return self.title
