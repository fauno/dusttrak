require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe Medicion do
  describe '.promediar_cada' do
    it 'promedia los grd por separado' do
      create(:medicion, grd_id: 1, concentracion: 0.2)
      create(:medicion, grd_id: 1, concentracion: 0.8)
      create(:medicion, grd_id: 2, concentracion: 0.2)
      create(:medicion, grd_id: 2, concentracion: 0.4)

      promedios = Medicion.promediar_cada(24.hours).all

      promedios.size.must_equal 2
      promedios.each do |p|
        promedio = p.grd_id == 1 ? (0.2 + 0.8)/2 : (0.2 + 0.4)/2

        # con más de 5 decimales hay diferencia (wtf!)
        p.concentracion.round(5).must_equal promedio.round(5)
      end
    end

    it 'agrupa por rangos' do
      create(:medicion, grd_id: 1, created_at: DateTime.now)
      create(:medicion, grd_id: 1, created_at: DateTime.now + 20.minutes)
      create(:medicion, grd_id: 2, created_at: DateTime.now)
      create(:medicion, grd_id: 2, created_at: DateTime.now + 20.minutes)

      Medicion.promediar_cada(15.minutes).all.size.must_equal 4
    end
  end
end
