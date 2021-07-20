describe Bakery do
  let(:bakery1) { Bakery.first }
  let(:bakery2) { Bakery.second }

  before do
    bakery1 = Bakery.create(name: "Northside")
    bakery2 = Bakery.create(name: "Southside")
    BakedGood.create(name: "Croissant", price: 3, bakery_id: bakery1.id)
    BakedGood.create(name: "Bagel", price: 2, bakery_id: bakery2.id)
    BakedGood.create(name: "Banana Bread", price: 3, bakery_id: bakery2.id)
  end
  
  it "has the correct columns in the bakeries table" do
    expect(bakery1).to have_attributes(name: "Northside")
  end

  it "knows about its associated baked goods" do
    expect(bakery2.baked_goods.count).to eq(2)
  end
  
end
