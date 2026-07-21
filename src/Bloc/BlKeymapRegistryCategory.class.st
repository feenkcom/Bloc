Class {
	#name : #BlKeymapRegistryCategory,
	#superclass : #Object,
	#instVars : [
		'keymaps',
		'label'
	],
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlKeymapRegistryCategory class >> registryLabel [
	^'Registry'
]

{ #category : #initialize }
BlKeymapRegistryCategory >> combinationFor: aShortcutId [
	^ (keymaps at: aShortcutId) combination
]

{ #category : #initialize }
BlKeymapRegistryCategory >> combinationForMacOSFor: aShortcutId [
	^ (keymaps at: aShortcutId) combinationForMacOS
]

{ #category : #initialize }
BlKeymapRegistryCategory >> combinationForUnixFor: aShortcutId [
	^ (keymaps at: aShortcutId) combinationForUnix
]

{ #category : #initialize }
BlKeymapRegistryCategory >> combinationForWindowsFor: aShortcutId [
	^ (keymaps at: aShortcutId) combinationForWindows
]

{ #category : #accessing }
BlKeymapRegistryCategory >> defaultLabel [
	^self class registryLabel
]

{ #category : #views }
BlKeymapRegistryCategory >> gtPhlowChildren [
	^keymaps values
]

{ #category : #views }
BlKeymapRegistryCategory >> gtShortcutCombinationsFor: aView [
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
BlKeymapRegistryCategory >> hasCombinationFor: aShortcutId [
	^ keymaps includesKey: aShortcutId
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initialize [
	super initialize.
	
	keymaps := Dictionary new.
	self initializeCombinations.
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializeBasicCombinations [
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializeCombinations [
	self initializeBasicCombinations.
	self initializePluggableCombinations.
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializePluggableCombinations [
	| pragmas |
	pragmas := Pragma allNamed: #gtKeymapRegistration from: self class to: BlKeymapRegistryCategory.
	pragmas do: [ :aPragma |
		self perform: aPragma methodSelector ]
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializeShortcut: aShortcut  windows: aWindowsKeyCombination unix: aUnixKeyCombination macOs: aMacOsKeyCombination  default: aDefaultCOmbination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new  
		combination: aDefaultCOmbination;
		combinationForWindows: aWindowsKeyCombination;
		combinationForUnix: aUnixKeyCombination;
		combinationForMacOS: aMacOsKeyCombination)
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializeShortcut: aShortcutId with: aKeyCombination [ 
	keymaps at: aShortcutId put: (BlRegistryKeymapEntry new 
		shortcutId: aShortcutId;
		combination: aKeyCombination)
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializeShortcut: aShortcut with: aKeyCombination  macOs: aMacOsKeyCombination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new 
		combination: aKeyCombination;
		combinationForMacOS: aMacOsKeyCombination)
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializeShortcut: aShortcut with: aKeyCombination  unix: aUnixKeyCombination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new 
		combination: aKeyCombination;
		combinationForUnix: aUnixKeyCombination)
]

{ #category : #initialize }
BlKeymapRegistryCategory >> initializeShortcut: aShortcut with: aKeyCombination  windows: aWindowsKeyCombination [
	keymaps at: aShortcut put: (BlRegistryKeymapEntry new 
		combination: aKeyCombination;
		combinationForWindows: aWindowsKeyCombination)
]

{ #category : #testing }
BlKeymapRegistryCategory >> isKeyCombinationEntry [
	^false
]

{ #category : #accessing }
BlKeymapRegistryCategory >> label [
	^label ifNil: [ self defaultLabel ]
]

{ #category : #accessing }
BlKeymapRegistryCategory >> label: aString [
	label := aString
]

{ #category : #accessing }
BlKeymapRegistryCategory >> numberOfKeymaps [
	^keymaps size
]
