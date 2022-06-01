from django.contrib import admin

# Register your models here.
from .models import *


class ClientsAdmin(admin.ModelAdmin):
    list_display = ['id','email','fullname','phone','isadmin'] 

class CourierAdmin(admin.ModelAdmin):
    list_display = ['id','email','fullname','phone','status']

class OrdersAdmin(admin.ModelAdmin):
    list_display = ['id','date', 'status','courier','delivery_address','client']

class FeedbacksAdmin(admin.ModelAdmin):
    list_display = ['rating','advantages', 'disadvantages','comment','pio']

class AddressesToShopsAdmin(admin.ModelAdmin):
    list_display = ['shop','address']

class AddressesToClientsAdmin(admin.ModelAdmin):
    list_display = ['client','address']

class ProductsInShopsAdmin(admin.ModelAdmin):
    list_display = ['product_id','shop']

class ProductsInOrdersAdmin(admin.ModelAdmin):
    list_display = ['product','order']


admin.site.register(Client, ClientsAdmin)
admin.site.register(Courier, CourierAdmin)
admin.site.register(Orders, OrdersAdmin)
admin.site.register(Feedback, FeedbacksAdmin)
admin.site.register(AddressesToShops, AddressesToShopsAdmin)
admin.site.register(AddressesToClients, AddressesToClientsAdmin)
admin.site.register(ProductsInShops, ProductsInShopsAdmin)
admin.site.register(ProductsInOrders, ProductsInOrdersAdmin)

admin.site.register(Shop)
admin.site.register(Address)





