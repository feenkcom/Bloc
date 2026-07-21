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

{ #category : #'gt - extensions' }
BlShortcutKeymapRegistry >> gtResetActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons refresh;
		tooltip: 'Reset registry';
		priority: 1;
		action: [ :aButton | 
			self reset.
			aButton phlow fireToolUpdateWish ]
]

{ #category : #'gt - extensions' }
BlShortcutKeymapRegistry >> gtSummaryFor: aView [
	<gtView>
	registryCategoriesByName ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Summary';
		priority: 50;
		items: [
			| allEntries macEntries winEntries unixEntries |
			allEntries := registryCategoriesByName values flatCollect: [ :cat | cat gtPhlowChildren ].
			macEntries := allEntries select: [ :e | e rawCombinationForMacOS notNil ].
			winEntries := allEntries select: [ :e | e rawCombinationForWindows notNil ].
			unixEntries := allEntries select: [ :e | e rawCombinationForUnix notNil ].
			{
				'Registry categories' -> registryCategoriesByName values.
				'Total shortcuts' -> allEntries.
				'With macOS combination' -> macEntries.
				'With Windows combination' -> winEntries.
				'With Unix combination' -> unixEntries.
			} ];
		column: 'Property' text: [ :each | each key ];
		column: 'Count' text: [ :each | each value size ];
		send: [ :each | each value ]
]

{ #category : #'gt - extensions' }
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
		priority: 20;
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

{ #category : #printing }
BlShortcutKeymapRegistry >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		| categories totalShortcuts |
		categories := registryCategoriesByName size.
		totalShortcuts := registryCategoriesByName values 
			inject: 0 
			into: [ :sum :each | sum + each numberOfKeymaps ].
		aStream 
			print: categories;
			nextPutAll: ' categories, ';
			print: totalShortcuts;
			nextPutAll: ' shortcuts' ]
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
