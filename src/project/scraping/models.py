from django.db import models

# Create your models here.
class Card(models.Model):
    id = models.BigIntegerField(primary_key=True)
    name = models.CharField(max_length=255)
    type = models.CharField(max_length=100)
    frame_type = models.CharField(max_length=50)
    desc = models.TextField()
    atk = models.IntegerField(null=True, blank=True)
    defense = models.IntegerField(null=True, blank=True)
    level = models.IntegerField(null=True, blank=True)
    race = models.CharField(max_length=100)
    attribute = models.CharField(max_length=50)

    class Meta:
        db_table = 'cards'

    def __str__(self):
        return self.name
    
class CardSet(models.Model):
    card = models.ForeignKey(Card, related_name="card_set", on_delete=models.CASCADE)
    set_name = models.CharField(max_length=255)
    set_code = models.CharField(max_length=50)
    set_rarity = models.CharField(max_length=100)
    set_rarity_code = models.CharField(max_length=20)
    set_price = models.DecimalField(max_digits=6, decimal_places=2)

    class Meta:
        db_table = 'card_set'
    
    def __str__(self):
        return self.set_name

class CardPrice(models.Model):
    card = models.OneToOneField(Card, related_name='card_prices', on_delete=models.CASCADE)
    cardmarket_price = models.DecimalField(max_digits=6, decimal_places=2)
    tcgplayer_price = models.DecimalField(max_digits=6, decimal_places=2)
    ebay_price = models.DecimalField(max_digits=6, decimal_places=2)
    amazon_price = models.DecimalField(max_digits=6, decimal_places=2)
    coolstuffinc_price = models.DecimalField(max_digits=6, decimal_places=2)

    class Meta:
        db_table = 'card_price'

    def __str__(self):
        return self.card.name
    
    


