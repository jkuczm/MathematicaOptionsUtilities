(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`RestoreOptions`"];


sym1OptionsDefault = {
	"sym1Opt1" -> "sym1Opt1ValDefault",
	"sym1Opt2" :> "sym1Opt2ValDefault"
};
sym1Options1 = {
	"sym1Opt1" -> "sym1Opt1Val1",
	"sym1Opt2" :> "sym1Opt2Val1"
};
sym1Options2 = {
	"sym1Opt1" -> "sym1Opt1Val2",
	"sym1Opt2" :> "sym1Opt2Val2"
};

sym2OptionsDefault = {"sym2Opt1" -> "sym2Opt1ValDefault"};
sym2Options1 = {"sym2Opt1" -> "sym2Opt1Val1"};
sym2Options2 = {"sym2Opt1" -> "sym2Opt1Val2"};

initial$SavedOptions = {
	uniqueId1 -> {sym1 -> sym1Options1},
	uniqueId2 -> {sym1 -> sym1Options2, sym2 -> sym2Options2}
}


(* ::Section:: *)
(*Tests*)


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[]
		,
		Null
		,
		TestID -> "No restore arguments: \
RestoreOptions evaluation: \
Null returned, \
no messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1Options2
		,
		TestID -> "No restore arguments: \
after restoration sym1 has restored second options set"
	];
	Test[
		Options[sym2]
		,
		sym2Options2
		,
		TestID -> "No restore arguments: \
after restoration sym2 has restored second options set"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			uniqueId1 -> {sym1 -> sym1Options1}
		}
		,
		TestID -> "No restore arguments: \
uniqueId2 was last id and was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[uniqueId1]
		,
		Null
		,
		TestID -> "Restore arguments: id containing one symbol: \
RestoreOptions evaluation: \
Null returned, \
no messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1Options1
		,
		TestID -> "Restore arguments: id containing one symbol: \
after restoration sym1 has restored first options set"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "Restore arguments: id containing one symbol: \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			uniqueId2 -> {sym1 -> sym1Options2, sym2 -> sym2Options2}
		}
		,
		TestID -> "Restore arguments: id containing one symbol: \
uniqueId1 was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[{sym1}]
		,
		Null
		,
		TestID -> "Restore argument: {sym1}: \
RestoreOptions evaluation: \
Null returned, \
no messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1Options2
		,
		TestID -> "Restore argument: {sym1}: \
after restoration sym1 has restored second options set"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "Restore argument: {sym1}: \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		initial$SavedOptions
		,
		TestID -> "Restore argument: {sym1}: \
no id was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[uniqueId1, {sym1}]
		,
		Null
		,
		TestID -> "Restore arguments: uniqueId1, {sym1}: \
RestoreOptions evaluation: \
Null returned, \
no messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1Options1
		,
		TestID -> "Restore arguments: uniqueId1, {sym1}: \
after restoration sym1 has restored first options set"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "Restore arguments: uniqueId1, {sym1}: \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		initial$SavedOptions
		,
		TestID -> "Restore arguments: uniqueId1, {sym1}: \
no id was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions["DeleteUsedId" -> False]
		,
		Null
		,
		TestID -> "No restore arguments, option \"DeleteUsedId\" -> False: \
RestoreOptions evaluation: \
Null returned, \
no messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1Options2
		,
		TestID -> "No restore arguments, option \"DeleteUsedId\" -> False: \
after restoration sym1 has restored second options set"
	];
	Test[
		Options[sym2]
		,
		sym2Options2
		,
		TestID -> "No restore arguments, option \"DeleteUsedId\" -> False: \
after restoration sym2 has restored second options set"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		initial$SavedOptions
		,
		TestID -> "No restore arguments, option \"DeleteUsedId\" -> False: \
no id was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[{sym1}, "DeleteUsedId" -> True]
		,
		Null
		,
		TestID -> "Restore argument: {sym1}, option \"DeleteUsedId\" -> True: \
RestoreOptions evaluation: \
Null returned, \
no messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1Options2
		,
		TestID -> "Restore argument: {sym1}, option \"DeleteUsedId\" -> True: \
after restoration sym1 has restored second options set"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "Restore argument: {sym1}, option \"DeleteUsedId\" -> True: \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{
			uniqueId1 -> {sym1 -> sym1Options1}
		}
		,
		TestID -> "Restore argument: {sym1}, option \"DeleteUsedId\" -> True: \
no id was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[uniqueId3]
		,
		$Failed
		,
		{
			HoldForm @ Message[
				RestoreOptions::unknownId,
				uniqueId3,
				{uniqueId1, uniqueId2},
				HoldForm[RestoreOptions[uniqueId3]]
			]
		}
		,
		TestID -> "Restore arguments: non-existing id: \
RestoreOptions evaluation: \
$Failed returned, \
warning messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1OptionsDefault
		,
		TestID -> "Restore arguments: non-existing id: \
after restoration sym1 still has default options"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "Restore arguments: non-existing id: \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		initial$SavedOptions
		,
		TestID -> "Restore arguments: non-existing id: \
no id was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[{sym3}]
		,
		$Failed
		,
		{
			HoldForm @ Message[
				RestoreOptions::unknownSymbols,
				{sym3},
				uniqueId2,
				{sym1, sym2},
				{sym3},
				HoldForm[RestoreOptions[{sym3}]]
			]
		}
		,
		TestID -> "Restore arguments: non-existing symbol: \
RestoreOptions evaluation: \
$Failed returned, \
warning messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1OptionsDefault
		,
		TestID -> "Restore arguments: non-existing symbol: \
after restoration sym1 still has default options"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "Restore arguments: non-existing symbol: \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		initial$SavedOptions
		,
		TestID -> "Restore arguments: non-existing symbol: \
no id was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = initial$SavedOptions}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions["DeleteUsedId" -> "something"]
		,
		$Failed
		,
		{
			HoldForm @ Message[
				RestoreOptions::unknownOptionValue,
				"something",
				"DeleteUsedId",
				{Automatic, True, False},
				HoldForm[RestoreOptions["DeleteUsedId" -> "something"]]
			]
		}
		,
		TestID -> "No restore arguments, \
unknown value of\"DeleteUsedId\" option \
RestoreOptions evaluation: \
$Failed returned, \
warning messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1OptionsDefault
		,
		TestID -> "No restore arguments, \
unknown value of\"DeleteUsedId\" option \
after restoration sym1 still has default options"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "No restore arguments, \
unknown value of\"DeleteUsedId\" option \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		initial$SavedOptions
		,
		TestID -> "No restore arguments, \
unknown value of\"DeleteUsedId\" option \
no id was removed from $SavedOptions"
	];
];


Block[
	{OptionsUtilities`Private`$SavedOptions = {}}
	,
	
	(* Define default options. *)
	Options[sym1] = sym1OptionsDefault;
	Options[sym2] = sym2OptionsDefault;
	
	
	Test[
		RestoreOptions[]
		,
		$Failed
		,
		{
			HoldForm @ Message[
				RestoreOptions::noSavedOptions,
				HoldForm[RestoreOptions[]]
			]
		}
		,
		TestID -> "Restore with empty $SavedOptions, \
unknown value of\"DeleteUsedId\" option \
RestoreOptions evaluation: \
$Failed returned, \
warning messages generated"
	];
	
	
	Test[
		Options[sym1]
		,
		sym1OptionsDefault
		,
		TestID -> "Restore with empty $SavedOptions, \
unknown value of\"DeleteUsedId\" option \
after restoration sym1 still has default options"
	];
	Test[
		Options[sym2]
		,
		sym2OptionsDefault
		,
		TestID -> "Restore with empty $SavedOptions, \
unknown value of\"DeleteUsedId\" option \
after restoration sym2 still has default options"
	];
	
	
	Test[
		OptionsUtilities`Private`$SavedOptions
		,
		{}
		,
		TestID -> "Restore with empty $SavedOptions, \
unknown value of\"DeleteUsedId\" option \
no id was removed from $SavedOptions"
	];
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
