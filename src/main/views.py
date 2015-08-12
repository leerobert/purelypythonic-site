from django.shortcuts import render
from django.utils import timezone
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from blog.models import Post

def home(request):
	post_list = Post.objects.filter(
		published_date__lte=timezone.now()
	).order_by('published_date')

	paginator = Paginator(post_list, 5) # Show 5 posts per page
	page = request.GET.get('page')
	try:
		posts = paginator.page(page)
	except PageNotAnInteger:
		# If page is not an integer, deliver first page.
		posts = paginator.page(1)
	except EmptyPage:
		# If page is out of range (e.g. 9999), deliver last page of results.
		posts = paginator.page(paginator.num_pages)

	return render(request, 'main/home.html', {'posts': posts})

def about(request):
	return render(request, 'main/about.html', {})

def projects(request):
	return render(request, 'main/projects.html', {})

def contact(request):
	return render(request, 'main/contact.html', {})