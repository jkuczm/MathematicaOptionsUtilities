(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


Begin["TestEnvironment`Acceptance`SaveRestoreOptions`complex`"];


sym1Options1 = {"sym1Opt1" -> "sym1Opt1Val1", "sym1Opt2" :> "sym1Opt2Val1"};
sym1Options2 = {"sym1Opt1" -> "sym1Opt1Val2", "sym1Opt2" :> "sym1Opt2Val2"};
sym1Options3 = {"sym1Opt1" -> "sym1Opt1Val3", "sym1Opt2" :> "sym1Opt2Val3"};

sym2Options1 = {"sym2Opt1" -> "sym2Opt1Val1"};
sym2Options2 = {"sym2Opt1" -> "sym2Opt1Val2"};
sym2Options3 = {"sym2Opt1" -> "sym2Opt1Val3"};


(* Define options for sym1 and sym2 with first set of options. *)
Options[sym1] = sym1Options1;
Options[sym2] = sym2Options1;


(* ::Section:: *)
(*Tests*)


(* Save first set of options for sym2 and stores unique id in
	optionsId1. *)
optionsId1 = SaveOptions[sym2];


(* Set second set of options for sym1. *)
SetOptions[sym1, sym1Options2];
Test[
	Options[sym1]
	,
	sym1Options2
	,
	TestID -> "sym1 has second set of options set"
];


(* Set second set of options for sym2. *)
SetOptions[sym2, sym2Options2];
Test[
	Options[sym2]
	,
	sym2Options2
	,
	TestID -> "sym2 has second set of options set"
];


(* Save second set of options for sym1 and sym2 and stores unique
	id in optionsId2. *)
optionsId2 = SaveOptions[sym1, sym2];


(* Set third set of options for sym1. *)
SetOptions[sym1, sym1Options3];
Test[
	Options[sym1]
	,
	sym1Options3
	,
	TestID -> "sym1 has third set of options set"
];


(* Set third set of options for sym2. *)
SetOptions[sym2, sym2Options3];
Test[
	Options[sym2]
	,
	sym2Options3
	,
	TestID -> "sym2 has third set of options set"
];


(* Restore options using first id but does not delete this set of options. *)
RestoreOptions[optionsId1, "DeleteUsedId" -> False];
Test[
	Options[sym1]
	,
	sym1Options3
	,
	TestID -> "sym1 still has third set of options \
(because options for sym1 were not saved in first id)"
];
Test[
	Options[sym2]
	,
	sym2Options1
	,
	TestID -> "sym2 has restored first set of options"
];


(* Restore options using second id but only for sym1. *)
RestoreOptions[optionsId2, {sym1}];
Test[
	Options[sym1]
	,
	sym1Options2
	,
	TestID -> "sym1 has restored second set of options"
];
Test[
	Options[sym2]
	,
	sym2Options1
	,
	TestID -> "sym2 still has first set of options"
];


(* Restore last saved options. *)
RestoreOptions[];
Test[
	Options[sym1]
	,
	sym1Options2
	,
	TestID -> "sym1 has restored second set of options"
];
Test[
	Options[sym2]
	,
	sym2Options2
	,
	TestID -> "sym2 has restored second set of options"
];


(* Restore last saved options again. *)
RestoreOptions[];
Test[
	Options[sym1]
	,
	sym1Options2
	,
	TestID -> "sym1 still has second set of options \
(because options for sym1 were not saved in first id)"
];
Test[
	Options[sym2]
	,
	sym2Options1
	,
	TestID -> "sym2 has restored first set of options"
];


(* ::Section:: *)
(*TearDown*)


(* Remove all symbols defined in current context. *)
Unprotect["`*"];
Quiet[Remove["`*"], {Remove::rmnsm}];


End[];
