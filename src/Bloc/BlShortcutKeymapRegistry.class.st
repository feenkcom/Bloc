Class {
	#name : #BlShortcutKeymapRegistry,
	#superclass : #Object,
	#instVars : [
		'registryCategoriesByName'
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

{ #category : #cleanup }
BlShortcutKeymapRegistry class >> reset [
	uniqueInstance ifNotNil: [ :each |
		each reset ]
]

{ #category : #'instance creation' }
BlShortcutKeymapRegistry class >> uniqueInstance [
	^ uniqueInstance ifNil: [ 
		uniqueInstance := super new.
		uniqueInstance	initializeRegistryCategories.
		uniqueInstance ]
]

{ #category : #registries }
BlShortcutKeymapRegistry >> editor [
	<gtKeymapRegistry>
	^ self ensureRegistryCategoryOfType: BrEditorKeymapRegistry ifPresent: [ :each | each ]
]

{ #category : #utils }
BlShortcutKeymapRegistry >> ensureRegistryCategoryOfType: aRegistryCategoryClass ifPresent: aPresentBlock [
	^registryCategoriesByName 
		at: aRegistryCategoryClass registryLabel
		ifPresent: aPresentBlock
		ifAbsentPut: [ 
			aRegistryCategoryClass new ]
]

{ #category : #views }
BlShortcutKeymapRegistry >> gtViewKeymapsFor: aView [
	<gtView>
	registryCategoriesByName ifNil: [^aView empty].
	
	^(aView columnedTree)
		title: 'Keymaps';
		priority: 10;
		expandAll;
		items: [registryCategoriesByName values];
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

{ #category : #views }
BlShortcutKeymapRegistry >> gtViewRegistryCategoriesFor: aView [
	<gtView>
	registryCategoriesByName ifNil: [ ^aView empty ].
	
	^(aView columnedList)
		title: 'Categories';
		items: [ registryCategoriesByName associations ];
		column: 'Name' text: [:each | each key capitalize ];
		column: 'Number of keymaps' text: [:each | each value numberOfKeymaps ];
		send: [ :each | each value ]
]

{ #category : #initialize }
BlShortcutKeymapRegistry >> initialize [
	super initialize.
	
	self resetRegistryCategories.
]

{ #category : #initialize }
BlShortcutKeymapRegistry >> initializeRegistryCategories [
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
	
	^ self ensureRegistryCategoryOfType: LeKeymapRegistry  ifPresent:  [ :each | each ]
]

{ #category : #initialize }
BlShortcutKeymapRegistry >> reset [
	self 
		resetRegistryCategories;
		initializeRegistryCategories
]

{ #category : #initialize }
BlShortcutKeymapRegistry >> resetRegistryCategories [
	registryCategoriesByName := SmallDictionary new.
]
