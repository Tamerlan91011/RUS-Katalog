from django.contrib import admin
from .models import *


class PriceHistoryAdmin(admin.ModelAdmin):
    list_display = ['product_id', 'price', 'date']


class MeidaAdmin(admin.ModelAdmin):
    list_display = ['filename', 'objectType', 'objectID']


admin.site.register(PriceHistory, PriceHistoryAdmin)
admin.site.register(Media, MeidaAdmin)
