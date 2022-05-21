# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models




"""
POSTGRESQL MODELS
"""
class Answer(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    question = models.ForeignKey('Question', models.DO_NOTHING, db_column='Question_ID')  # Field name made lowercase.
    content = models.TextField(db_column='Content')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'answer'


class Category(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=-1, blank=True, null=True)  # Field name made lowercase.
    parent_category = models.ForeignKey('self', models.DO_NOTHING, db_column='Parent_Category_ID', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'category'


class Product(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    brand = models.CharField(db_column='Brand', max_length=-1)  # Field name made lowercase.
    model = models.CharField(db_column='Model', max_length=-1)  # Field name made lowercase.
    item_number = models.CharField(db_column='Item_number', max_length=-1)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=-1, blank=True, null=True)  # Field name made lowercase.
    category = models.ForeignKey(Category, models.DO_NOTHING, db_column='Category_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'product'


class Question(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    product = models.ForeignKey(Product, models.DO_NOTHING, db_column='Product_ID')  # Field name made lowercase.
    username = models.CharField(db_column='Username', max_length=-1)  # Field name made lowercase.
    article = models.CharField(db_column='Article', max_length=-1)  # Field name made lowercase.
    content = models.TextField(db_column='Content', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'question'


class Review(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    product = models.ForeignKey(Product, models.DO_NOTHING, db_column='Product_ID')  # Field name made lowercase.
    username = models.CharField(db_column='Username', max_length=-1)  # Field name made lowercase.
    article = models.CharField(db_column='Article', max_length=-1)  # Field name made lowercase.
    content = models.TextField(db_column='Content', blank=True, null=True)  # Field name made lowercase.
    comment = models.TextField(db_column='Comment', blank=True, null=True)  # Field name made lowercase.
    rating = models.FloatField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'review'


class Specification(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=-1)  # Field name made lowercase.
    description = models.TextField(db_column='Description', blank=True, null=True)  # Field name made lowercase.
    unit = models.TextField(db_column='Unit')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'specification'


class SpecificationToProduct(models.Model):
    product = models.ForeignKey(Product, models.DO_NOTHING, db_column='Product_ID')  # Field name made lowercase.
    specification_value = models.ForeignKey('SpecificationValue', models.DO_NOTHING, db_column='Specification_value_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'specification_to_product'


class SpecificationValue(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    specification = models.ForeignKey(Specification, models.DO_NOTHING, db_column='Specification_ID')  # Field name made lowercase.
    value_int_field = models.IntegerField(db_column='Value(int)', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.
    value_float_field = models.FloatField(db_column='Value(float)', blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.
    value_string_field = models.CharField(db_column='Value(string)', max_length=-1, blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.

    class Meta:
        managed = False
        db_table = 'specification_value'









"""MICROSOFT SQL SERVER MODELS"""

class Address(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    city = models.CharField(db_column='City', max_length=50)  # Field name made lowercase.
    street = models.CharField(db_column='Street', max_length=50)  # Field name made lowercase.
    house = models.CharField(db_column='House', max_length=50)  # Field name made lowercase.
    flat = models.IntegerField(db_column='Flat', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Address'


class AddressesToClients(models.Model):
    client = models.OneToOneField('Client', models.DO_NOTHING, db_column='Client_ID', primary_key=True)  # Field name made lowercase.
    address = models.ForeignKey(Address, models.DO_NOTHING, db_column='Address_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Addresses_to_Clients'
        unique_together = (('client', 'address'),)


class AddressesToShops(models.Model):
    shop = models.OneToOneField('Shop', models.DO_NOTHING, db_column='Shop_ID', primary_key=True)  # Field name made lowercase.
    address = models.ForeignKey(Address, models.DO_NOTHING, db_column='Address_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Addresses_to_Shops'
        unique_together = (('shop', 'address'),)


class Client(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=50)  # Field name made lowercase.
    phone = models.CharField(db_column='Phone', max_length=50, blank=True, null=True)  # Field name made lowercase.
    password = models.CharField(db_column='Password', max_length=50)  # Field name made lowercase.
    fullname = models.CharField(db_column='Fullname', max_length=50)  # Field name made lowercase.
    isadmin = models.BooleanField(db_column='isAdmin')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Client'


class Courier(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=50)  # Field name made lowercase.
    phone = models.CharField(db_column='Phone', max_length=50)  # Field name made lowercase.
    password = models.CharField(db_column='Password', max_length=50)  # Field name made lowercase.
    fullname = models.CharField(db_column='Fullname', max_length=50)  # Field name made lowercase.
    status = models.CharField(db_column='Status', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Courier'


class Feedback(models.Model):
    pio = models.OneToOneField('ProductsInOrders', models.DO_NOTHING, db_column='PiO_ID', primary_key=True)  # Field name made lowercase.
    advantages = models.CharField(db_column='Advantages', max_length=50, blank=True, null=True)  # Field name made lowercase.
    disadvantages = models.CharField(db_column='Disadvantages', max_length=50, blank=True, null=True)  # Field name made lowercase.
    comment = models.CharField(db_column='Comment', max_length=50, blank=True, null=True)  # Field name made lowercase.
    rating = models.FloatField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Feedback'


class Orders(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    courier = models.ForeignKey(Courier, models.DO_NOTHING, db_column='Courier_ID')  # Field name made lowercase.
    client = models.ForeignKey(Client, models.DO_NOTHING, db_column='Client_ID')  # Field name made lowercase.
    status = models.CharField(db_column='Status', max_length=50)  # Field name made lowercase.
    date = models.DateField(db_column='Date')  # Field name made lowercase.
    delivery_address = models.CharField(db_column='Delivery_address', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Orders'


class ProductsInOrders(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    order = models.ForeignKey(Orders, models.DO_NOTHING, db_column='Order_ID')  # Field name made lowercase.
    product = models.ForeignKey('ProductsInShops', models.DO_NOTHING, db_column='Product_ID')  # Field name made lowercase.
    shop = models.ForeignKey('ProductsInShops', models.DO_NOTHING, db_column='Shop_ID')  # Field name made lowercase.
    amount = models.IntegerField(db_column='Amount')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Products_in_Orders'


class ProductsInShops(models.Model):
    product_id = models.IntegerField(db_column='Product_ID', primary_key=True)  # Field name made lowercase.
    shop = models.ForeignKey('Shop', models.DO_NOTHING, db_column='Shop_ID')  # Field name made lowercase.
    price = models.DecimalField(db_column='Price', max_digits=18, decimal_places=0, blank=True, null=True)  # Field name made lowercase.
    available_amount = models.IntegerField(db_column='Available_amount', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Products_in_Shops'
        unique_together = (('product_id', 'shop'),)


class Shop(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=50)  # Field name made lowercase.
    rating = models.FloatField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Shop'


