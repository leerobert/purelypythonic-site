from django.shortcuts import render, get_object_or_404

from .models import Post

def post(request, slug):
	post = get_object_or_404(Post, slug=slug)
	return render(request, 'blog/post.html', {'post': post})

def post_by_id(request, post_id):
	post = get_object_or_404(Post, pk=post_id)
	return render(request, 'blog/post.html', {'post': post})