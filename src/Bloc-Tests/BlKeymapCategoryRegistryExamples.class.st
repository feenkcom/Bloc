Class {
	#name : #BlKeymapCategoryRegistryExamples,
	#superclass : #Object,
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> basicRegistry [
	<gtExample>
	| registry |
	registry := BlShortcutKeymapRegistryCategory new.
	
	self assert: registry numberOfKeymaps equals: 0.
	self assert: registry label equals: 'Registry'.
	self assert: registry isKeyCombinationEntry not.
	
	^registry
]

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> checkRegistryWithExplicitCombinationForEachPlatforms [
	<gtExample>
	| registry shortcutId |
	registry := self basicRegistry.
	
	shortcutId := BlShortcutId  identifier: #SomeShortcut.
	registry 
		initializeShortcut: shortcutId
		windows: BlKeyCombination builder primary  a build
		unix: BlKeyCombination builder primary  b build
		macOs: BlKeyCombination builder primary  c build
		default: BlKeyCombination builder primary  d build.
	
	self assert: (registry hasCombinationFor: shortcutId).
	
	self assert: (registry combinationFor:  shortcutId) equals:  BlKeyCombination builder primary  d build.
	self assert: (registry combinationForMacOSFor:  shortcutId) equals:  BlKeyCombination builder primary  c build.
	self assert: (registry combinationForUnixFor:  shortcutId) equals:  BlKeyCombination builder primary  b build.
	self assert: (registry combinationForWindowsFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	
	^registry
]

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> checkRegistryWithExplicitMacOsCombination [
	<gtExample>
	| registry shortcutId |
	registry := self basicRegistry.
	
	shortcutId := BlShortcutId  identifier: #SomeShortcut.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination builder primary  a build
		macOs: BlKeyCombination builder primary  b build.
		
	self assert: (registry hasCombinationFor: shortcutId).
	
	self assert: (registry combinationFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	self assert: (registry combinationForMacOSFor:  shortcutId) equals:  BlKeyCombination builder primary  b build.
	self assert: (registry combinationForUnixFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	self assert: (registry combinationForWindowsFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	
	^registry
]

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> checkRegistryWithExplicitUnixCombination [
	<gtExample>
	| registry shortcutId |
	registry := self basicRegistry.
	
	shortcutId := BlShortcutId  identifier: #SomeShortcut.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination builder primary  a build
		unix: BlKeyCombination builder primary  b build.
	
	self assert: (registry hasCombinationFor: shortcutId).
	
	self assert: (registry combinationFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	self assert: (registry combinationForMacOSFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	self assert: (registry combinationForUnixFor:  shortcutId) equals:  BlKeyCombination builder primary b build.
	self assert: (registry combinationForWindowsFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	
	^registry
]

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> checkRegistryWithExplicitWindowsCombination [
	<gtExample>
	| registry shortcutId |
	registry := self basicRegistry.
	
	shortcutId := BlShortcutId  identifier: #SomeShortcut.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination builder primary  a build
		windows: BlKeyCombination builder primary  b build.
	
	self assert: (registry hasCombinationFor: shortcutId).
	
	self assert: (registry combinationFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	self assert: (registry combinationForMacOSFor:  shortcutId) equals:  BlKeyCombination builder primary  a build.
	self assert: (registry combinationForUnixFor:  shortcutId) equals:  BlKeyCombination builder primary a build.
	self assert: (registry combinationForWindowsFor:  shortcutId) equals:  BlKeyCombination builder primary b build.
	
	^registry
]

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> checkRegistryWithSameImplicitCombinationForAllPlatforms [
	<gtExample>
	| registry shortcutId |
	registry := self basicRegistry.
	
	shortcutId := BlShortcutId  identifier: #NewLine.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination return.
		
	self assert: (registry hasCombinationFor: shortcutId).
	
	self assert: (registry combinationFor:  shortcutId) equals:  BlKeyCombination return.
	self assert: (registry combinationForMacOSFor:  shortcutId) equals:  BlKeyCombination return.
	self assert: (registry combinationForUnixFor:  shortcutId) equals:  BlKeyCombination return.
	self assert: (registry combinationForWindowsFor:  shortcutId) equals:  BlKeyCombination return.
	
	^registry
]

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> checkResolvingIdNotPresentInRegistry [
	<gtExample>
	| registry shortcutId |
	registry := self basicRegistry.
	
	shortcutId := BlShortcutId  identifier: #SomeShortcut.
	
	self assert: (registry hasCombinationFor: shortcutId) not.
	
	self assert: (registry combinationFor:  shortcutId) equals: nil.
	self assert: (registry combinationForMacOSFor:  shortcutId) equals: nil.
	self assert: (registry combinationForUnixFor:  shortcutId) equals: nil.
	self assert: (registry combinationForWindowsFor:  shortcutId) equals: nil.
	
	^registry
]

{ #category : #'examples - shortcutId' }
BlKeymapCategoryRegistryExamples >> checkShortcutIdSetWithAllPlatformsCombination [
	<gtExample>
	<return: #BlShortcutKeymapRegistryCategory>
	"Verifies that initializeShortcut:windows:unix:macOs:default: sets the shortcutId on the entry"
	| registry shortcutId entry |
	registry := self basicRegistry.
	shortcutId := BlShortcutId identifier: #TestAllPlatforms.
	registry 
		initializeShortcut: shortcutId
		windows: BlKeyCombination builder primary a build
		unix: BlKeyCombination builder primary b build
		macOs: BlKeyCombination builder primary c build
		default: BlKeyCombination builder primary d build.
	entry := registry keymapFor: shortcutId.
	self assert: entry shortcutId equals: shortcutId.
	^ registry
]

{ #category : #'examples - shortcutId' }
BlKeymapCategoryRegistryExamples >> checkShortcutIdSetWithMacOsCombination [
	<gtExample>
	<return: #BlShortcutKeymapRegistryCategory>
	"Verifies that initializeShortcut:with:macOs: sets the shortcutId on the entry"
	| registry shortcutId entry |
	registry := self basicRegistry.
	shortcutId := BlShortcutId identifier: #TestMacOs.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination builder primary a build
		macOs: BlKeyCombination builder primary b build.
	entry := registry keymapFor: shortcutId.
	self assert: entry shortcutId equals: shortcutId.
	^ registry
]

{ #category : #'examples - shortcutId' }
BlKeymapCategoryRegistryExamples >> checkShortcutIdSetWithSimpleCombination [
	<gtExample>
	<return: #BlShortcutKeymapRegistryCategory>
	"Verifies that initializeShortcut:with: sets the shortcutId on the entry"
	| registry shortcutId entry |
	registry := self basicRegistry.
	shortcutId := BlShortcutId identifier: #TestShortcut.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination return.
	entry := registry keymapFor: shortcutId.
	self assert: entry shortcutId equals: shortcutId.
	^ registry
]

{ #category : #'examples - shortcutId' }
BlKeymapCategoryRegistryExamples >> checkShortcutIdSetWithUnixCombination [
	<gtExample>
	<return: #BlShortcutKeymapRegistryCategory>
	"Verifies that initializeShortcut:with:unix: sets the shortcutId on the entry"
	| registry shortcutId entry |
	registry := self basicRegistry.
	shortcutId := BlShortcutId identifier: #TestUnix.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination builder primary a build
		unix: BlKeyCombination builder primary b build.
	entry := registry keymapFor: shortcutId.
	self assert: entry shortcutId equals: shortcutId.
	^ registry
]

{ #category : #'examples - shortcutId' }
BlKeymapCategoryRegistryExamples >> checkShortcutIdSetWithWindowsCombination [
	<gtExample>
	<return: #BlShortcutKeymapRegistryCategory>
	"Verifies that initializeShortcut:with:windows: sets the shortcutId on the entry"
	| registry shortcutId entry |
	registry := self basicRegistry.
	shortcutId := BlShortcutId identifier: #TestWindows.
	registry 
		initializeShortcut: shortcutId
		with: BlKeyCombination builder primary a build
		windows: BlKeyCombination builder primary b build.
	entry := registry keymapFor: shortcutId.
	self assert: entry shortcutId equals: shortcutId.
	^ registry
]

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> registryWithKeymaps [
	<gtExample>
	| registry |
	registry := self basicRegistry.
	
	registry 
		initializeShortcut: (BlShortcutId  identifier: #NewLine)
		with: BlKeyCombination return.
	registry 
		initializeShortcut: (BlShortcutId  identifier: #LoseFocus)
		with: BlKeyCombination escape.
		
	registry 
		initializeShortcut: (BlShortcutId  identifier: #MoveCursorToNextWord)
		with: BlKeyCombination builder control arrowRight build
		macOs: BlKeyCombination builder alt arrowRight build.

	self assert: registry numberOfKeymaps equals: 3.
	self assert: (registry hasCombinationFor: (BlShortcutId  identifier: #NewLine)).
	self assert: (registry hasCombinationFor: (BlShortcutId  identifier: #NewLine2)) not.
	
	^registry
]

{ #category : #'examples - update' }
BlKeymapCategoryRegistryExamples >> updateShortcutCombination [
	<gtExample>
	"Verify that updateShortcutFor:with: changes the combination of an existing shortcut"
	| registry shortcutId originalCombination newCombination |
	registry := self registryWithKeymaps.
	
	shortcutId := BlShortcutId identifier: #NewLine.
	originalCombination := registry combinationFor: shortcutId.
	self assert: originalCombination equals: BlKeyCombination return.
	
	newCombination := BlKeyCombination builder shift return build.
	registry updateShortcutFor: shortcutId with: newCombination.
	
	self assert: (registry combinationFor: shortcutId) equals: newCombination.
	self assert: (registry combinationFor: shortcutId) ~= originalCombination.
	self assert: registry numberOfKeymaps equals: 3.
	
	^ registry
]

{ #category : #'examples - update' }
BlKeymapCategoryRegistryExamples >> updateShortcutCombinationForAbsentShortcut [
	<gtExample>
	"Verify that updateShortcutFor:with:ifAbsent: calls the absent block when the shortcut doesn't exist"
	| registry shortcutId newCombination absentBlockCalled |
	registry := self registryWithKeymaps.
	
	shortcutId := BlShortcutId identifier: #NonExistentShortcut.
	newCombination := BlKeyCombination builder primary a build.
	absentBlockCalled := false.
	
	registry 
		updateShortcutFor: shortcutId 
		with: newCombination 
		ifAbsent: [ absentBlockCalled := true ].
	
	self assert: absentBlockCalled.
	self assert: (registry hasCombinationFor: shortcutId) not.
	self assert: registry numberOfKeymaps equals: 3.
	
	^ registry
]

{ #category : #'examples - update' }
BlKeymapCategoryRegistryExamples >> updateShortcutCombinationForExistingShortcut [
	<gtExample>
	"Verify that updateShortcutFor:with:ifAbsent: updates the combination when the shortcut exists"
	| registry shortcutId newCombination absentBlockCalled |
	registry := self registryWithKeymaps.
	
	shortcutId := BlShortcutId identifier: #LoseFocus.
	newCombination := BlKeyCombination builder primary escape build.
	absentBlockCalled := false.
	
	registry 
		updateShortcutFor: shortcutId 
		with: newCombination 
		ifAbsent: [ absentBlockCalled := true ].
	
	self assert: absentBlockCalled not.
	self assert: (registry combinationFor: shortcutId) equals: newCombination.
	
	^ registry
]
