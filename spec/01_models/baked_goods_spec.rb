describe BakedGood do
  let(:baked_good1) { BakedGood.first }
  let(:baked_good2) { BakedGood.second }

  before do
    bakery1 = Bakery.create(name: "Northside")
    bakery2 = Bakery.create(name: "Southside")
    BakedGood.create(name: "Croissant", price: 3, bakery_id: bakery1.id)
    BakedGood.create(name: "Bagel", price: 2, bakery_id: bakery2.id)
  end
  
  it "has the correct columns in the baked_goods table" do
    expect(baked_good1).to have_attributes(name: "Croissant", price: 3, bakery_id: Bakery.first.id)
  end

  it "knows about its associated bakery" do
    expect(baked_good1.bakery).to eq(Bakery.first)
  end
  
end
