"""rus_katalog URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include, re_path

import delivery.views
import web.views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/categories/', web.views.CategoryAPIView.as_view()),
    path('api/products/', web.views.ProductAPIView.as_view()),
    path('api/prices/', delivery.views.PriceAPIView.as_view()),
    path('api/shops/', delivery.views.ShopAPIView.as_view()),
    path('api/rating/', delivery.views.RatingAPIView.as_view()),
    path('api/specifications/', web.views.SpecificationAPIView.as_view()),
    path('api/feedback/', delivery.views.FeedbackAPIView.as_view()),
    path('api/auth/login/', delivery.views.LoginAPIView.as_view()),
    path('api/auth/logout/', delivery.views.LogoutAPIView.as_view()),
    path('api/auth/register/', delivery.views.RegisterAPIView.as_view()),
]
