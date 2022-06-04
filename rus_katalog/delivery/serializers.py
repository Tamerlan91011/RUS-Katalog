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


class FeedbackSerializer(serializers.ModelSerializer):
    pio = ProductsInOrdersSerializer()

    class Meta:
        model = Feedback
        fields = ('pio', 'advantages', 'disadvantages', 'comment', 'rating')


class ClientFullSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = ('id', 'email', 'phone', 'password', 'fullname', 'isadmin')

