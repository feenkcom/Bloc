Class {
	#name : #BlRegistryKeymapEntry,
	#superclass : #Object,
	#instVars : [
		'combination',
		'combinationForUnix',
		'combinationForMacOS',
		'combinationForWindows',
		'shortcutId'
	],
	#category : 'Bloc-Events-KeyBinding'
}

{ #category : #accessing }
BlRegistryKeymapEntry >> combination [
	^combination
]

{ #category : #accessing }
BlRegistryKeymapEntry >> combination: aKeyCombination [
	combination := aKeyCombination
]

{ #category : #accessing }
BlRegistryKeymapEntry >> combinationForMacOS [
	^combinationForMacOS ifNil: [self combination]
]

{ #category : #accessing }
BlRegistryKeymapEntry >> combinationForMacOS: aKeyCombination [
	combinationForMacOS := aKeyCombination
]

{ #category : #accessing }
BlRegistryKeymapEntry >> combinationForUnix [
	^combinationForUnix ifNil: [self combination]
]

{ #category : #accessing }
BlRegistryKeymapEntry >> combinationForUnix: aKeyCombination [
	combinationForUnix := aKeyCombination
]

{ #category : #accessing }
BlRegistryKeymapEntry >> combinationForWindows [
	^combinationForWindows ifNil: [self combination]
]

{ #category : #accessing }
BlRegistryKeymapEntry >> combinationForWindows: aKeyCombination [
	combinationForWindows := aKeyCombination
]

{ #category : #views }
BlRegistryKeymapEntry >> gtPhlowChildren [
	^#()
]

{ #category : #testing }
BlRegistryKeymapEntry >> isKeyCombinationEntry [
	^true
]

{ #category : #accessing }
BlRegistryKeymapEntry >> label [
	^ shortcutId identifier asString
]

{ #category : #printing }
BlRegistryKeymapEntry >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [
		aStream 
			nextPutAll: self label;
			nextPutAll: ' -> '.
		combination 
			ifNotNil: [ aStream print: combination ]
			ifNil: [ aStream nextPutAll: 'nil' ].
		combinationForWindows ifNotNil: [ :c |
			aStream nextPutAll: ' win: '; print: c ].
		combinationForMacOS ifNotNil: [ :c |
			aStream nextPutAll: ' mac: '; print: c ].
		combinationForUnix ifNotNil: [ :c |
			aStream nextPutAll: ' unix: '; print: c ] ]
]

{ #category : #accessing }
BlRegistryKeymapEntry >> rawCombinationForMacOS [
	^combinationForMacOS 
]

{ #category : #accessing }
BlRegistryKeymapEntry >> rawCombinationForUnix [
	^combinationForUnix 
]

{ #category : #accessing }
BlRegistryKeymapEntry >> rawCombinationForWindows [
	^combinationForWindows 
]

{ #category : #accessing }
BlRegistryKeymapEntry >> shortcutId [
	^shortcutId
]

{ #category : #accessing }
BlRegistryKeymapEntry >> shortcutId: aShortcutId [	
	shortcutId := aShortcutId	
]
