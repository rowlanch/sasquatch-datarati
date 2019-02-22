
filename cities ZIP 'C:\sasquatch-data\500Cities.zip';

DATA project.Cities2016;
	LENGTH
		Year	8
		StateAbbr	$ 2
		StateDesc	$ 50
		CityName	$ 50
		GeographicLevel	$ 12
		DataSource	$ 5
		Category  $ 19
		UniqueID	$ 19
		Measure	 $ 192
		Data_Value_Unit		$ 1
		DataValueTypeID		$ 9
		Data_Value_Type		$ 23
		Data_Value 	8
		Data_Value_Footnote_Symbol	$ 1
		Data_Value_Footnote		$ 48
		Low_Confidence_Limit	8
		High_Confidence_Limit	8
		Population2010	8
		GeoLocation		$ 33
		CategoryID	 $ 7
		MeasureId	 $ 12
		CityFIPS	8
		TractFIPS	8
		Short_Question_Text	$ 40;
	INFILE cities(500Cities2016.csv)
		delimiter=',' DSD lrecl=32767 firstobs=2 ;
	INPUT
		Year
		StateAbbr
		StateDesc
		CityName
		GeographicLevel
		DataSource
		Category
		UniqueID
		Measure	
		Data_Value_Unit	
		DataValueTypeID	
		Data_Value_Type	
		Data_Value
		Data_Value_Footnote_Symbol
		Data_Value_Footnote	
		Low_Confidence_Limit
		High_Confidence_Limit
		Population2010
		GeoLocation
		CategoryID
		MeasureId
		CityFIPS
		TractFIPS
		Short_Question_Text	;
RUN;