require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike}
  it { is_expected.to respond_to(:dock).with(1).argument} 
  #it { is_expected.to respond_to(:stored_bikes) }

  describe "#release_bike" do
    it "releases a bike" do 
      bike = Bike.new
      subject.dock(bike)
      expect(subject.release_bike).to eq bike
    end

    it "releases working bikes" do
      bike = Bike.new
      subject.dock(bike)
      subject.release_bike
      expect(bike).to be_working
    end

    it "raises an error when no bikes available" do 
      expect{ subject.release_bike }.to raise_error "No bikes available"  
    end
    
    it "does not release a broken bike" do 
      bike = Bike.new
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error "Bike broken, can't be released"      
    end
     

  end 
  
  describe '#dock' do
    it "docks bike" do
      bike = Bike.new
      expect(subject.dock(bike)).to eq [bike]
    end

    it "raises an error when docking station is at full capacity" do
      docking_station = DockingStation.new(50)
      50.times { docking_station.dock(Bike.new) }
      expect { docking_station.dock(Bike.new) }.to raise_error "Docking station full"
    end

    it "raises an error using default capacity" do
      subject.capacity.times { subject.dock(Bike.new) }
      expect { subject.dock(Bike.new) }.to raise_error "Docking station full"
    end
  end

  describe '#capacity' do
    it "specifies larger capacity when necessary" do 
      expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
    end  
  end



end

