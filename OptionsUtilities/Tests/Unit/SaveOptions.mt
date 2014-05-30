(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`SaveOptions`"];


sym1Options1 = {"sym1Opt1" -> "sym1Opt1Val1", "sym1Opt2" :> "sym1Opt2Val1"};
sym1Options2 = {"sym1Opt1" -> "sym1Opt1Val2", "sym1Opt2" :> "sym1Opt2Val2"};

sym2Options1 = {"sym2Opt1" -> "sym2Opt1Val1"};
sym2Options2 = {"sym2Opt2" -> "sym2Opt1Val2"};


(* Define options. *)
Options[sym1] = sym1Options1;
Options[sym2] = sym2Options1;


(* ::Section:: *)
(*Tests*)


Block[
	{OptionsUtilities`Private`$SavedOptions = {}}
	,
	
	
	Test[
		StringTake[
			SymbolName[optionsId = SaveOptions[{sym1, sym2}]],
			13
		]
		,
		"savedOptions$"
		,
		TestID -> "List of 2 symbols: \
SaveOptions evaluation: \
Symbol with name starting with \"savedOptions$\" returned, \
no messages generated"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			optionsId -> {sym1 -> sym1Options1, sym2 -> sym2Options1}
		}
		,
		TestID -> "List of 2 symbols: \
$SavedOptions contains saved options marked with proper identifier"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = {}}
	,
	
	
	Test[
		SaveOptions[sym1, "UniqueIdentifier" -> uniqueId]
		,
		uniqueId
		,
		TestID -> "1 symbol, explicit \"UniqueIdentifier\" option: \
SaveOptions evaluation: \
symbol given as \"UniqueIdentifier\" returned, \
no messages generated"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			uniqueId -> {sym1 -> sym1Options1}
		}
		,
		TestID -> "1 symbol, explicit \"UniqueIdentifier\" option: \
$SavedOptions contains saved options marked with proper identifier"
	];
];


Block[
	{
		OptionsUtilities`Private`$SavedOptions =
			{uniqueId -> {sym1 -> sym1Options2}}
	}
	,
	
	
	Test[
		SaveOptions[sym2, "UniqueIdentifier" -> uniqueId]
		,
		uniqueId
		,
		TestID -> "Append to existing identifier: \
SaveOptions evaluation: \
symbol given as \"UniqueIdentifier\" returned, \
no messages generated"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			uniqueId -> {sym1 -> sym1Options2, sym2 -> sym2Options1}
		}
		,
		TestID -> "Append to existing identifier: \
$SavedOptions contains saved options marked with proper identifier"
	];
];


Block[
	{
		OptionsUtilities`Private`$SavedOptions =
			{uniqueId -> {sym1 -> sym1Options2}}
	}
	,
	
	
	Test[
		SaveOptions[sym1, "UniqueIdentifier" -> uniqueId]
		,
		uniqueId
		,
		TestID -> "Replace symbol options in existing identifier: \
SaveOptions evaluation: \
symbol given as \"UniqueIdentifier\" returned, \
no messages generated"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			uniqueId -> {sym1 -> sym1Options1}
		}
		,
		TestID -> "Replace symbol options in existing identifier: \
$SavedOptions contains saved options marked with proper identifier"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = {}}
	,
	
	
	Test[
		StringTake[
			SymbolName[
				optionsId =
					SaveOptions[
						sym1, symNoOptions, "SaveEmptyOptions" -> False
					]
			],
			13
		]
		,
		"savedOptions$"
		,
		TestID -> "\"SaveEmptyOptions\" -> False: \
SaveOptions evaluation: \
Symbol with name starting with \"savedOptions$\" returned, \
no messages generated"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			optionsId -> {sym1 -> sym1Options1}
		}
		,
		TestID -> "\"SaveEmptyOptions\" -> False: \
$SavedOptions contains saved options marked with proper identifier"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = {}}
	,
	
	
	Test[
		StringTake[
			SymbolName[
				optionsId =
					SaveOptions[
						sym1, symNoOptions, "SaveEmptyOptions" -> True
					]
			],
			13
		]
		,
		"savedOptions$"
		,
		TestID -> "\"SaveEmptyOptions\" -> True: \
SaveOptions evaluation: \
Symbol with name starting with \"savedOptions$\" returned, \
no messages generated"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			optionsId -> {sym1 -> sym1Options1, symNoOptions -> {}}
		}
		,
		TestID -> "\"SaveEmptyOptions\" -> True: \
$SavedOptions contains saved options marked with proper identifier"
	];
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
