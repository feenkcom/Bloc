Class {
	#name : #BlShortcutKeymapRegistryCategory,
	#superclass : #Object,
	#instVars : [
		'keymaps',
		'label'
	],
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlShortcutKeymapRegistryCategory class >> registryLabel [
	^'Registry'
]

{ #category : #'accessing - combinations' }
BlShortcutKeymapRegistryCategory >> combinationFor: aShortcutId [
	^self 
		keymapFor: aShortcutId 
		ifPresent: [ :each | each combination ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - combinations' }
BlShortcutKeymapRegistryCategory >> combinationForMacOSFor: aShortcutId [
	^self 
		keymapFor: aShortcutId 
		ifPresent: [ :each | each combinationForMacOS ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - combinations' }
BlShortcutKeymapRegistryCategory >> combinationForUnixFor: aShortcutId [
	^self 
		keymapFor: aShortcutId 
		ifPresent: [ :each | each combinationForUnix ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - combinations' }
BlShortcutKeymapRegistryCategory >> combinationForWindowsFor: aShortcutId [
	^self 
		keymapFor: aShortcutId 
		ifPresent: [ :each | each combinationForWindows ]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
BlShortcutKeymapRegistryCategory >> defaultLabel [
	^self class registryLabel
]

{ #category : #views }
BlShortcutKeymapRegistryCategory >> gtPhlowChildren [
	^keymaps values
]

{ #category : #views }
BlShortcutKeymapRegistryCategory >> gtShortcutCombinationsFor: aView [
	<gtView>
	keymaps ifNil: [^aView empty].
	^(aView columnedList)
		title: 'Combinations';
		items: [keymaps associations];
		column: 'Id' text: [:each | each key gtDisplayString] width: 250;
		column: 'Main Combination' text: [:each | each value combination gtDisplayString];
		column: 'Windows' text: [:each | each value rawCombinationForWindows ifNil: [ '-' ] ];
		column: 'MacOs' text: [:each | each value rawCombinationForMacOS ifNil: [ '-' ] ];
		column: 'Unix' text: [:each | each value rawCombinationForUnix ifNil: [ '-' ] ];
		send: [:each | each value]
]

{ #category : #testing }
BlShortcutKeymapRegistryCategory >> hasCombinationFor: aShortcutId [
	^ keymaps includesKey: aShortcutId
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initialize [
	super initialize.
	
	keymaps := Dictionary new.
	self initializeCombinations.
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializeBasicCombinations [
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializeCombinations [
	self initializeBasicCombinations.
	self initializePluggableCombinations.
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializePluggableCombinations [
	| pragmas |
	pragmas := Pragma allNamed: #gtKeymapRegistration from: self class to: BlShortcutKeymapRegistryCategory.
	pragmas do: [ :aPragma |
		self perform: aPragma methodSelector ]
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializeShortcut: aShortcut  windows: aWindowsKeyCombination unix: aUnixKeyCombination macOs: aMacOsKeyCombination  default: aDefaultCOmbination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new  
		combination: aDefaultCOmbination;
		combinationForWindows: aWindowsKeyCombination;
		combinationForUnix: aUnixKeyCombination;
		combinationForMacOS: aMacOsKeyCombination)
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializeShortcut: aShortcutId with: aKeyCombination [ 
	keymaps at: aShortcutId put: (BlRegistryKeymapEntry new 
		shortcutId: aShortcutId;
		combination: aKeyCombination)
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializeShortcut: aShortcut with: aKeyCombination  macOs: aMacOsKeyCombination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new 
		combination: aKeyCombination;
		combinationForMacOS: aMacOsKeyCombination)
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializeShortcut: aShortcut with: aKeyCombination  unix: aUnixKeyCombination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new 
		combination: aKeyCombination;
		combinationForUnix: aUnixKeyCombination)
]

{ #category : #initialize }
BlShortcutKeymapRegistryCategory >> initializeShortcut: aShortcut with: aKeyCombination  windows: aWindowsKeyCombination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new 
		combination: aKeyCombination;
		combinationForWindows: aWindowsKeyCombination)
]

{ #category : #testing }
BlShortcutKeymapRegistryCategory >> isKeyCombinationEntry [
	^false
]

{ #category : #accessing }
BlShortcutKeymapRegistryCategory >> keymapFor: aShortcutId [
	^ keymaps at: aShortcutId
]

{ #category : #accessing }
BlShortcutKeymapRegistryCategory >> keymapFor: aShortcutId ifAbsent: anAbsentBlock [
	^ keymaps at: aShortcutId ifAbsent: anAbsentBlock
]

{ #category : #accessing }
BlShortcutKeymapRegistryCategory >> keymapFor: aShortcutId ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ keymaps at: aShortcutId  ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #accessing }
BlShortcutKeymapRegistryCategory >> label [
	^label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
BlShortcutKeymapRegistryCategory >> label: aString [
	label := aString
]

{ #category : #accessing }
BlShortcutKeymapRegistryCategory >> numberOfKeymaps [
	^keymaps size
]

{ #category : #'accessing - combinations' }
BlShortcutKeymapRegistryCategory >> updateShortcutFor: aShortcutId with: aCombination [ 
	(self keymapFor: aShortcutId)
			combination: aCombination
]

{ #category : #'accessing - combinations' }
BlShortcutKeymapRegistryCategory >> updateShortcutFor: aShortcutId with: aCombination ifAbsent: anAbsentBlock [
	| keymap |
	keymap := self keymapFor: aShortcutId ifAbsent: [ ^ anAbsentBlock value ].
	keymap combination: aCombination
]
