Class {
	#name : #BlKeymapCategoryRegistryExamples,
	#superclass : #Object,
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #examples }
BlKeymapCategoryRegistryExamples >> basicRegistry [
	<gtExample>
	| registry |
	registry := BlKeymapRegistryCategory new.
	
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
	
	self assert: (registry combinationFor:  shortcutId) equals:  BlKeyCombination return.
	self assert: (registry combinationForMacOSFor:  shortcutId) equals:  BlKeyCombination return.
	self assert: (registry combinationForUnixFor:  shortcutId) equals:  BlKeyCombination return.
	self assert: (registry combinationForWindowsFor:  shortcutId) equals:  BlKeyCombination return.
	
	^registry
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
