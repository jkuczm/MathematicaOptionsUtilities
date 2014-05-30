(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`CopyFeatures`"];


(* Mock base functions *)
ClearAll["baseFunc*"];

Options[baseFunc1] = {
	"opt1" -> "opt1ValueBaseFunc1"
};
baseFunc1[] := "baseFunc1"
SetAttributes[baseFunc1, HoldFirst];

Options[baseFunc2] = {
	"opt1" -> "opt1ValueBaseFunc2",
	"opt2" -> "opt2ValueBaseFunc2"
};
baseFunc2[] := "baseFunc2"
SetAttributes[baseFunc2, {HoldRest, Protected, Orderless}];


(* ::Section:: *)
(*Tests*)


Module[
	{f}
	,
	
	Test[
		CopyFeatures[baseFunc1, f]
		,
		Null
		,
		TestID -> "one \"from\" func, one \"to\" func: \
CopyFeatures evaluation returns Null, no messages are generated"
	];
	Test[
		Attributes[f]
		,
		{HoldFirst}
		,
		TestID -> "one \"from\" func, one \"to\" func: \
\"to\" func have proper attributes"
	];
	Test[
		Options[f]
		,
		{"opt1" -> "opt1ValueBaseFunc1"}
		,
		TestID -> "one \"from\" func, one \"to\" func: \
\"to\" func have proper options"
	];
]


Module[
	{f, g}
	,
	
	Test[
		CopyFeatures[baseFunc1, {f, g}]
		,
		Null
		,
		TestID -> "one \"from\" func, two \"to\" func: \
CopyFeatures evaluation returns Null, no messages are generated"
	];
	
	Test[
		Attributes[f]
		,
		{HoldFirst}
		,
		TestID -> "one \"from\" func, two \"to\" func: \
first \"to\" func have proper attributes"
	];
	Test[
		Attributes[g]
		,
		{HoldFirst}
		,
		TestID -> "one \"from\" func, two \"to\" func: \
second \"to\" func have proper attributes"
	];
	
	Test[
		Options[f]
		,
		{"opt1" -> "opt1ValueBaseFunc1"}
		,
		TestID -> "one \"from\" func, two \"to\" func: \
first \"to\" func have proper options"
	];
	Test[
		Options[g]
		,
		{"opt1" -> "opt1ValueBaseFunc1"}
		,
		TestID -> "one \"from\" func, two \"to\" func: \
second \"to\" func have proper options"
	];
]


Module[
	{f}
	,
	
	Test[
		CopyFeatures[{baseFunc1, baseFunc2}, f]
		,
		Null
		,
		TestID -> "two \"from\" func, one \"to\" func: \
CopyFeatures evaluation returns Null, no messages are generated"
	];
	Test[
		Attributes[f]
		,
		{HoldAll, Orderless}
		,
		TestID -> "one \"from\" func, one \"to\" func: \
\"to\" func have proper attributes"
	];
	Test[
		Options[f]
		,
		{
			"opt1" -> "opt1ValueBaseFunc1",
			"opt2" -> "opt2ValueBaseFunc2"
		}
		,
		TestID -> "one \"from\" func, one \"to\" func: \
\"to\" func have proper options"
	];
]


Module[
	{f, g}
	,
	
	Test[
		CopyFeatures[{baseFunc1, baseFunc2}, {f, g}]
		,
		Null
		,
		TestID -> "two \"from\" func, two \"to\" func: \
CopyFeatures evaluation returns Null, no messages are generated"
	];
	
	Test[
		Attributes[f]
		,
		{HoldAll, Orderless}
		,
		TestID -> "two \"from\" func, two \"to\" func: \
first \"to\" func have proper attributes"
	];
	Test[
		Attributes[g]
		,
		{HoldAll, Orderless}
		,
		TestID -> "two \"from\" func, two \"to\" func: \
second \"to\" func have proper attributes"
	];
	
	Test[
		Options[f]
		,
		{
			"opt1" -> "opt1ValueBaseFunc1",
			"opt2" -> "opt2ValueBaseFunc2"
		}
		,
		TestID -> "two \"from\" func, two \"to\" func: \
first \"to\" func have proper options"
	];
	Test[
		Options[g]
		,
		{
			"opt1" -> "opt1ValueBaseFunc1",
			"opt2" -> "opt2ValueBaseFunc2"
		}
		,
		TestID -> "two \"from\" func, two \"to\" func: \
second \"to\" func have proper options"
	];
]


Module[
	{f}
	,
	
	Test[
		CopyFeatures[
			baseFunc2, f,
			"ExcludeAttributes" -> {HoldRest, Orderless}
		]
		,
		Null
		,
		TestID -> "one \"from\" func, one \"to\" func; \
\"ExcludeAttributes\" -> {HoldRest, Orderless}: \
CopyFeatures evaluation returns Null, no messages are generated"
	];
	Test[
		Attributes[f]
		,
		{Protected}
		,
		TestID -> "one \"from\" func, one \"to\" func; \
\"ExcludeAttributes\" -> {HoldRest, Orderless}: \
\"to\" func have proper attributes"
	];
	Test[
		Options[f]
		,
		{
			"opt1" -> "opt1ValueBaseFunc2",
			"opt2" -> "opt2ValueBaseFunc2"
		}
		,
		TestID -> "one \"from\" func, one \"to\" func; \
\"ExcludeAttributes\" -> {HoldRest, Orderless}: \
\"to\" func have proper options"
	];
]


Module[
	{f}
	,
	
	Test[
		CopyFeatures[baseFunc2, f, "ExcludeOptions" -> {"opt1"}]
		,
		Null
		,
		TestID -> "one \"from\" func, one \"to\" func; \
\"ExcludeOptions\" -> {\"opt1\"}: \
CopyFeatures evaluation returns Null, no messages are generated"
	];
	Test[
		Attributes[f]
		,
		{HoldRest, Orderless}
		,
		TestID -> "one \"from\" func, one \"to\" func; \
\"ExcludeOptions\" -> {\"opt1\"}: \
\"to\" func have proper attributes"
	];
	Test[
		Options[f]
		,
		{"opt2" -> "opt2ValueBaseFunc2"}
		,
		TestID -> "one \"from\" func, one \"to\" func; \
\"ExcludeOptions\" -> {\"opt1\"}: \
\"to\" func have proper options"
	];
]


Module[
	{f}
	,
	
	Test[
		CopyFeatures[
			{baseFunc1, baseFunc2}, f,
			"DeleteOptionDuplicates" -> False
		]
		,
		Null
		,
		TestID -> "two \"from\" func, one \"to\" func: \
\"DeleteOptionDuplicates\" -> False: \
CopyFeatures evaluation returns Null, no messages are generated"
	];
	Test[
		Attributes[f]
		,
		{HoldAll, Orderless}
		,
		TestID -> "one \"from\" func, one \"to\" func: \
\"DeleteOptionDuplicates\" -> False: \
\"to\" func have proper attributes"
	];
	Test[
		Options[f]
		,
		{
			"opt1" -> "opt1ValueBaseFunc1",
			"opt1" -> "opt1ValueBaseFunc2",
			"opt2" -> "opt2ValueBaseFunc2"
		}
		,
		TestID -> "one \"from\" func, one \"to\" func: \
\"DeleteOptionDuplicates\" -> False: \
\"to\" func have proper options"
	];
]


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
