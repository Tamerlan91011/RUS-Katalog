# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Answer(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    question = models.ForeignKey('Question', models.DO_NOTHING, db_column='Question_ID')  # Field name made lowercase.
    content = models.TextField(db_column='Content')  # Field name made lowercase.

    def __str__(self):
        return str(self.question) + ' Ответ: ' + str(self.content)

    class Meta:
        managed = False
        db_table = 'answer'


class Category(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=255, blank=True, null=True)  # Field name made lowercase.
    parent_category = models.ForeignKey('self', models.DO_NOTHING, db_column='Parent_Category_ID', blank=True, null=True)  # Field name made lowercase.

    def __str__(self):
        return self.name


    class Meta:
        db_table = 'category'


class Product(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    brand = models.CharField(db_column='Brand', max_length=255)  # Field name made lowercase.
    model = models.CharField(db_column='Model', max_length=255)  # Field name made lowercase.
    item_number = models.CharField(db_column='Item_number', max_length=255)  # Field name made lowercase.
    description = models.CharField(db_column='Description', max_length=255, blank=True, null=True)  # Field name made lowercase.
    category = models.ForeignKey(Category, models.DO_NOTHING, db_column='Category_ID')  # Field name made lowercase.

    def __str__(self):
        return self.model

    class Meta:
        managed = False
        db_table = 'product'


class Question(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    product = models.ForeignKey(Product, models.DO_NOTHING, db_column='Product_ID')  # Field name made lowercase.
    username = models.CharField(db_column='Username', max_length=255)  # Field name made lowercase.
    article = models.CharField(db_column='Article', max_length=255)  # Field name made lowercase.
    content = models.TextField(db_column='Content', blank=True, null=True)  # Field name made lowercase.

    def __str__(self) -> str:
        return str(self.id)+ ': '+ self.content
    

    class Meta:
        managed = False
        db_table = 'question'


class Review(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    product = models.ForeignKey(Product, models.DO_NOTHING, db_column='Product_ID')  # Field name made lowercase.
    username = models.CharField(db_column='Username', max_length=255)  # Field name made lowercase.
    article = models.CharField(db_column='Article', max_length=255)  # Field name made lowercase.
    content = models.TextField(db_column='Content', blank=True, null=True)  # Field name made lowercase.
    comment = models.TextField(db_column='Comment', blank=True, null=True)  # Field name made lowercase.
    rating = models.FloatField(db_column='Rating', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'review'


class Specification(models.Model):
    id = models.IntegerField(db_column='ID', primary_key=True)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=255)  # Field name made lowercase.
    description = models.TextField(db_column='Description', blank=True, null=True)  # Field name made lowercase.
    unit = models.TextField(db_column='Unit')  # Field name made lowercase.

    def __str__(self):
        return (self.name + ': ' + self.unit)

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
    value_string_field = models.CharField(db_column='Value(string)', max_length=255, blank=True, null=True)  # Field name made lowercase. Field renamed to remove unsuitable characters. Field renamed because it ended with '_'.

    class Meta:
        managed = False
        db_table = 'specification_value'
