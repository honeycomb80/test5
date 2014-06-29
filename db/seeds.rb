if Word.all.count < 200 
  200.times do
    Word.create(ord: Forgery(:lorem_ipsum).words(1, :random => true, :unique => true))
  end
end

if Article.all.count < 100
  100.times do
    Article.create(title: Forgery(:lorem_ipsum).words(10, :random => true), date: Forgery(:date).date(:past => true), url: Forgery(:internet).domain_name)
  end
end

if Count.all.count < 100
  100.times do
    Count.create(qty: Forgery(:basic).number(:at_most => 100), article_id: Forgery(:basic).number(:at_most => 100), word_id: Forgery(:basic).number(:at_most => 10))
  end
end
