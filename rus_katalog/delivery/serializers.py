from rest_framework import serializers
from .models import *


class ShopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        fields = ('id', 'name', 'rating')


class ProductsInShopsSerializer(serializers.ModelSerializer):
    shop = ShopSerializer()

    class Meta:
        model = ProductsInShops
        fields = ('product_id', 'shop', 'price', 'available_amount')


class MinPricesSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductsInShops
        fields = ('price', )


class ClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = ('fullname',)


class OrderSerializer(serializers.ModelSerializer):
    client = ClientSerializer()

    class Meta:
        model = Orders
        fields = ('client',)


class ProductsInOrdersSerializer(serializers.ModelSerializer):
    order = OrderSerializer()
    shop = ProductsInShopsSerializer()

    class Meta:
        model = ProductsInOrders
        fields = ('id', 'order', 'shop')


class ProductsInOrdersFullSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductsInOrders
        fields = ('id', 'order', 'product', 'shop', 'amount')


class FeedbackSerializer(serializers.ModelSerializer):
    pio = ProductsInOrdersSerializer()

    class Meta:
        model = Feedback
        fields = ('pio', 'advantages', 'disadvantages', 'comment', 'rating')


class ClientFullSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = ('id', 'email', 'phone', 'password', 'fullname', 'isadmin')


class OrderFullSerializer(serializers.ModelSerializer):
    class Meta:
        model = Orders
        fields = ('id', 'courier', 'client', 'status', 'date', 'delivery_address')


class OrdersOfClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Orders
        fields = ('id', 'status', 'date', 'delivery_address')


class ProductsInOrdersOfClientSerializer(serializers.ModelSerializer):
    order = OrdersOfClientSerializer()
    shop = ProductsInShopsSerializer()

    class Meta:
        model = ProductsInOrders
        fields = ('id', 'order', 'product', 'shop', 'amount')


class AddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = Address
        fields = ('id', 'city', 'street', 'house', 'flat')


class AddressesToClientsSerializer(serializers.ModelSerializer):
    address = AddressSerializer()

    class Meta:
        model = AddressesToClients
        fields = ('address',)

