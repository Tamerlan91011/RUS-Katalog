from django.contrib import admin

# Register your models here.
from .models import *


class SpecificationValAdmin(admin.ModelAdmin):
    list_display = ['specification', 'value_int_field', 'value_float_field', 'value_string_field']


class ProductsAdmin(admin.ModelAdmin):
    list_display = ['id', 'category', 'brand', 'model', 'item_number']


class QuestionsAdmin(admin.ModelAdmin):
    list_display = ['id', 'product', 'username', 'article', 'content']


class ReviewAdmin(admin.ModelAdmin):
    list_display = ['id', 'product', 'rating', 'username', 'article', 'content', 'comment']


admin.site.register(SpecificationValue, SpecificationValAdmin)
admin.site.register(Product, ProductsAdmin)
admin.site.register(Question, QuestionsAdmin)
admin.site.register(Review, ReviewAdmin)
admin.site.register(SpecificationToProduct)

admin.site.register(Specification)
admin.site.register(Category)
admin.site.register(Answer)
