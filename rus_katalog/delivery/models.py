# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Address(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    city = models.CharField(db_column='City', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    street = models.CharField(db_column='Street', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    house = models.CharField(db_column='House', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    flat = models.IntegerField(db_column='Flat', blank=True, null=True)  # Field name made lowercase.

    def __str__(self):
        return (self.city +', '+ self.street + ', ' + self.house + ', ' + str(self.flat))

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
    email = models.CharField(db_column='Email', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    phone = models.CharField(db_column='Phone', max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)  # Field name made lowercase.
    password = models.CharField(db_column='Password', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    fullname = models.CharField(db_column='Fullname', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    isadmin = models.BooleanField(db_column='isAdmin')  # Field name made lowercase.


    def __str__(self):
        return self.fullname

    class Meta:
        db_table = 'Client'


class Courier(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    phone = models.CharField(db_column='Phone', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    password = models.CharField(db_column='Password', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    fullname = models.CharField(db_column='Fullname', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    status = models.CharField(db_column='Status', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.

    def __str__(self):
        return self.phone


    class Meta:
        managed = False
        db_table = 'Courier'


class Feedback(models.Model):
    pio = models.OneToOneField('ProductsInOrders', models.DO_NOTHING, db_column='PiO_ID', primary_key=True)  # Field name made lowercase.
    advantages = models.CharField(db_column='Advantages', max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)  # Field name made lowercase.
    disadvantages = models.CharField(db_column='Disadvantages', max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)  # Field name made lowercase.
    comment = models.CharField(db_column='Comment', max_length=50, db_collation='Cyrillic_General_CI_AS', blank=True, null=True)  # Field name made lowercase.
    rating = models.FloatField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Feedback'


class Orders(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    courier = models.ForeignKey(Courier, models.DO_NOTHING, db_column='Courier_ID')  # Field name made lowercase.
    client = models.ForeignKey(Client, models.DO_NOTHING, db_column='Client_ID')  # Field name made lowercase.
    status = models.CharField(db_column='Status', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    date = models.DateField(db_column='Date')  # Field name made lowercase.
    delivery_address = models.CharField(db_column='Delivery_address', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.

    def __str__(self):
        return str(self.id)
    class Meta:
        managed = False
        db_table = 'Orders'


class ProductsInOrders(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    order = models.ForeignKey(Orders, models.DO_NOTHING, db_column='Order_ID')  # Field name made lowercase.
    product = models.ForeignKey('ProductsInShops', models.DO_NOTHING, db_column='Product_ID', related_name='product')  # Field name made lowercase.
    shop = models.ForeignKey('ProductsInShops', models.DO_NOTHING, db_column='Shop_ID')  # Field name made lowercase.
    amount = models.IntegerField(db_column='Amount')  # Field name made lowercase.

    def __str__(self) -> str:
        return str(self.product) + '. Заказ с ID = ' + str(self.order)


    class Meta:
        managed = False
        db_table = 'Products_in_Orders'


class ProductsInShops(models.Model):
    product_id = models.IntegerField(db_column='Product_ID', primary_key=True)  # Field name made lowercase.
    shop = models.ForeignKey('Shop', models.DO_NOTHING, db_column='Shop_ID')  # Field name made lowercase.
    price = models.DecimalField(db_column='Price', max_digits=18, decimal_places=0, blank=True, null=True)  # Field name made lowercase.
    available_amount = models.IntegerField(db_column='Available_amount', blank=True, null=True)  # Field name made lowercase.

    def __str__(self) -> str:
        return 'Товар с ID = '+ str(self.product_id) + ' в магазине: ' + str(self.shop)


    class Meta:
        managed = False
        db_table = 'Products_in_Shops'
        unique_together = (('product_id', 'shop'),)


class Shop(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=50, db_collation='Cyrillic_General_CI_AS')  # Field name made lowercase.
    rating = models.FloatField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.

    def __str__(self):
        return self.name + ': ' + str(self.rating)
    class Meta:
        managed = False
        db_table = 'Shop'

