from django.db import models
from djongo.models import ObjectIdField


class PriceHistory(models.Model):
    _id = ObjectIdField()
    product_id = models.IntegerField(db_column='productID')
    price = models.FloatField(db_column='price')
    date = models.DateField(db_column='date')

    def __str__(self):
        return f"Товар с ID - {self.product_id} стоил {self.price} Р на момент {self.date}"

    class Meta:
        db_table = "PriceHistory"




class Media(models.Model):
    _id = ObjectIdField()
    filename = models.CharField(db_column='filename', max_length=255)
    objectType = models.CharField(db_column='objectType', max_length=255)
    objectID = models.IntegerField(db_column='objectID')

    def __str__(self):
        return f"Файл \"{self.filename}\" для объекта {self.objectType} с ID - {self.objectID}"

    class Meta:
        db_table = "Media"
