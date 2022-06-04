from rest_framework import serializers
from .models import *


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ('id', 'name', 'parent_category_id')


class SpecificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Specification
        fields = ('id', 'name', 'description', 'unit')


class SpecificationValueSerializer(serializers.ModelSerializer):
    class Meta:
        model = SpecificationValue
        fields = ('id', 'specification', 'value_int_field', 'value_float_field', 'value_string_field')


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ('id', 'brand', 'model', 'item_number', 'description', 'category')


class SpecificationToProductSerializer(serializers.ModelSerializer):
    specification_value = SpecificationValueSerializer()

    class Meta:
        model = SpecificationToProduct
        fields = ('specification_value',)
