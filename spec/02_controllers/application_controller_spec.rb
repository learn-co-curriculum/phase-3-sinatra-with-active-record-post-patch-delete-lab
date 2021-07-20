describe ApplicationController do
  let(:bakery1) { Bakery.first }
  let(:bakery2) { Bakery.second }

  before do
    bakery1 = Bakery.create(name: "Northside")
    bakery2 = Bakery.create(name: "Southside")
    BakedGood.create(name: "Croissant", price: 5, bakery_id: bakery1.id)
    BakedGood.create(name: "Bagel", price: 2, bakery_id: bakery1.id)
    BakedGood.create(name: "Banana Bread", price: 3, bakery_id: bakery2.id)
  end

  describe 'GET /bakeries' do
    it 'sets the Content-Type header in the response to application/json' do
      get '/bakeries'

      expect(last_response.headers['Content-Type']).to eq('application/json')
    end

    it 'returns an array of JSON objects for all bakeries in the database' do
      get '/bakeries'

      expect(last_response.body).to include_json([
        { name: "Northside" },
        { name: "Southside" }
      ])
    end
  end

  describe 'GET /bakeries/:id' do
    it 'sets the Content-Type header in the response to application/json' do
      get "/bakeries/#{bakery1.id}"

      expect(last_response.headers['Content-Type']).to eq('application/json')
    end

    it 'returns a single bakery as JSON with its baked goods nested' do
      get "/bakeries/#{bakery1.id}"

      expect(last_response.body).to include_json({ 
        name: "Northside",
        baked_goods: [
          { name: "Croissant", price: 5 },
          { name: "Bagel", price: 2 }
        ]
      })
    end
  end

  describe 'GET /baked_goods/by_price' do
    it "returns an array of baked goods as JSON, sorted by price in descending order" do
      get "/baked_goods/by_price"

      expect(last_response.body).to include_json([
        { name: "Croissant", price: 5 },
        { name: "Banana Bread", price: 3 },
        { name: "Bagel", price: 2 }
      ])
    end
  end

  describe 'GET /baked_goods/most_expensive' do
    it 'returns the single most expensive baked good as JSON (HINT: how can you sort the baked goods in a particular order?)' do
      get "/baked_goods/most_expensive"

      expect(last_response.body).to include_json({ name: "Croissant", price: 5 })
    end
  end

  describe 'POST /baked_goods' do
    let(:params) do
      { name: "Lemon Poppyseed Muffin", price: 3, bakery_id: bakery1.id }
    end

    it 'creates a new baked good in the database' do
      expect { post "/baked_goods", params }.to change(BakedGood, :count).from(3).to(4)
    end

    it 'returns data for the newly created baked good as JSON' do
      post "/baked_goods", params

      expect(last_response.body).to include_json({ name: "Lemon Poppyseed Muffin", price: 3, bakery_id: bakery1.id })
    end
  end

  describe 'PATCH /bakeries/:id' do
    let(:params) do
      { name: "Northwestside Bakery" }
    end

    it 'updates the name of the bakery in the database' do
      expect do 
        patch "/bakeries/#{bakery1.id}", params 

        # Active Record caches attributes, so we must reload them to see what has changed
        bakery1.reload
      end.to change(bakery1, :name).to("Northwestside Bakery")
    end

    it 'returns data for the updated bakery as JSON' do
      patch "/bakeries/#{bakery1.id}", params

      expect(last_response.body).to include_json({ name: "Northwestside Bakery" })
    end
  end

  describe 'DELETE /baked_goods/:id' do
    it 'deletes the baked_good from the database' do
      expect { delete "/bakeries/#{bakery1.id}" }.to change(Bakery, :count).from(2).to(1)
    end
  end

end
