Class {
	#name : #BlShortcutKeymapRegistry,
	#superclass : #Object,
	#instVars : [
		'categoriesByName'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : #cleanup }
BlShortcutKeymapRegistry class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #accessing }
BlShortcutKeymapRegistry class >> default [
	^self uniqueInstance
]

{ #category : #'instance creation' }
BlShortcutKeymapRegistry class >> uniqueInstance [

	^ uniqueInstance ifNil: [ 
		uniqueInstance := super new.
		uniqueInstance	initializeRegistries.
		uniqueInstance ]
]

{ #category : #registries }
BlShortcutKeymapRegistry >> editor [
	<gtKeymapRegistry>
	^ self ensureCategoryOfType: BrEditorKeymapRegistry ifPresent: [ :each | each ]
]

{ #category : #utils }
BlShortcutKeymapRegistry >> ensureCategoryOfType: aCategoryClass ifPresent: aPresentBlock [
	^categoriesByName 
		at: aCategoryClass registryLabel
		ifPresent: aPresentBlock
		ifAbsentPut: [ 
			aCategoryClass new ]
]

{ #category : #views }
BlShortcutKeymapRegistry >> gtViewCategoriesFor: aView [
	<gtView>
	categoriesByName ifNil: [^aView empty].
	
	^(aView columnedList)
		title: 'Categories';
		items: [categoriesByName associations];
		column: 'Name' text: [:each | each key capitalize ];
		column: 'Number of keymaps' text: [:each | each value numberOfKeymaps ];
		send: [ :each | each value ]
]

{ #category : #views }
BlShortcutKeymapRegistry >> gtViewKeymapsFor: aView [
	<gtView>
	categoriesByName ifNil: [^aView empty].
	
	^(aView columnedTree)
		title: 'Keymaps';
		priority: 10;
		expandAll;
		items: [categoriesByName values];
		children: [ :each | each gtPhlowChildren ];
		column: 'Name' text: [:each | each label ];
		column: 'Main combination' text: [:each | 
			each isKeyCombinationEntry 
				ifTrue: [ each combination ]
				ifFalse: [ '' ]  ];
			column: 'Windows' text: [:each | 
			each isKeyCombinationEntry 
				ifTrue: [ each rawCombinationForWindows ifNil: [ '-' ] ]
				ifFalse: [ '' ]  ];
		column: 'MacOs' text: [:each | 
			each isKeyCombinationEntry 
				ifTrue: [ each rawCombinationForMacOS ifNil: [ '-' ] ]
				ifFalse: [ '' ]  ];
		column: 'Unix' text: [:each | 
			each isKeyCombinationEntry 
				ifTrue: [ each rawCombinationForUnix ifNil: [ '-' ] ]
				ifFalse: [ '' ]  ]
]

{ #category : #initialize }
BlShortcutKeymapRegistry >> initialize [
	super initialize.
	
	categoriesByName := SmallDictionary new.
]

{ #category : #initialize }
BlShortcutKeymapRegistry >> initializeRegistries [
	| pragmas |
	pragmas := Pragma
				allNamed: #gtKeymapRegistry
				from: self class
				to: BlShortcutKeymapRegistry.
	pragmas do: [ :aPragma | self perform: aPragma methodSelector]
]

{ #category : #registries }
BlShortcutKeymapRegistry >> lepiter [
	<gtKeymapRegistry>
	^ self ensureCategoryOfType: LeKeymapRegistry  ifPresent:  [ :each | each ]
]
