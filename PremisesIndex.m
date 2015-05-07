function index=PremisesIndex(string)

index=[0 0 0];
if strcmp('Apartment Basement',string)
   index=[1 1 3];
elseif strcmp('Apartment',string)
    index=[1 1 2];
elseif strcmp('Apartment Hallway',string)
    index=[1 1 4];
elseif strcmp('House',string)
    index=[1 2 16];
elseif strcmp('Single-Family House',string)
    index=[1 2 28];
elseif strcmp('Two-Family House',string)
    index=[1 2 31];
elseif strcmp('Condominium',string)
    index=[1 3 9];
elseif strcmp('Porch',string)
    index=[1 4 23];
elseif strcmp('University',string)
    index=[2 5 32];
elseif strcmp('School', string)
    index=[2 5 26];
elseif strcmp('Dormitory',string)
    index=[2 6 11];
% elseif strcmp('Garage(Personal)',string)
%     index=[3 0 12];
elseif strcmp('Garage',string)
    index=[3 7 13];
elseif strcmp('Parking Garage',string)
    index=[3 7 21];
elseif strcmp('Parking Lot',string)
    index=[3 7 22];
% elseif strcmp('Warehouse Storage', string)
%     index=[4 0 15];
elseif strcmp('Storage',string)
    index=[4 8 29];
% elseif strcmp('Storage Warehouse',string)
%     index=[4 0 17];
elseif strcmp('Shelter',string)
    index=[5 9 27];
elseif strcmp('Assisted Living',string)
    index=[5 9 5];
elseif strcmp('Driveway',string)
    index=[6 10 12];
elseif strcmp('Street',string)
    index=[7 11 30];
elseif strcmp('Recreation Center',string)
    index=[8 12 24];
elseif strcmp('Cinema',string)
    index=[8 12 7];   
elseif strcmp('Construction Site', string)
    index=[9 13 10];
elseif strcmp('Medical Building', string)
    index=[10 14 17];
elseif strcmp('YMCA',string)
    index=[11 15 33];
elseif strcmp('Nursing Home',string)
    index=[12 16 18];
elseif strcmp('Church',string)
    index=[13 17 6];
elseif strcmp('Yard',string)
    index=[14 18 34];
elseif strcmp('Hotel/Motel',string)
    index=[15 19 15];
elseif strcmp('Research',string)
    index=[16 20 25];
elseif strcmp('Office Park',string)
    index=[17 21 19];
elseif strcmp('Commercial Unknown', string)
    index=[18 22 8];
elseif strcmp('Halfway House',string)
    index=[19 23 14];
elseif strcmp('Accounting Firm', string)
    index=[20 24 1];
elseif strcmp('Other Retail', string)
    index=[21 25 20];
end