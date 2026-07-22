"
I contain examples for {{gtClass:BlRegistryKeymapEntry}} verifying the behavior of default combinations, per-platform overrides (macOS, Windows, Unix), fallback logic, and updates.
"
Class {
	#name : #BlRegistryKeymapEntryExamples,
	#superclass : #Object,
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #examples }
BlRegistryKeymapEntryExamples >> basicEntry [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	| entry |
	entry := BlRegistryKeymapEntry new.
	
	self assert: entry shortcutId isNil.
	self assert: entry combination isNil.
	self assert: entry rawCombinationForMacOS isNil.
	self assert: entry rawCombinationForWindows isNil.
	self assert: entry rawCombinationForUnix isNil.
	self assert: entry isKeyCombinationEntry.
	self assert: entry gtPhlowChildren isEmpty.
	
	^ entry
]

{ #category : #'examples - platform fallback' }
BlRegistryKeymapEntryExamples >> combinationForMacOSFallsBackToDefault [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"When no macOS-specific combination is set, combinationForMacOS returns the default combination"
	| entry defaultCombination |
	entry := self entryWithDefaultCombination.
	defaultCombination := entry combination.
	
	self assert: entry rawCombinationForMacOS isNil.
	self assert: entry combinationForMacOS equals: defaultCombination.
	
	^ entry
]

{ #category : #'examples - platform fallback' }
BlRegistryKeymapEntryExamples >> combinationForUnixFallsBackToDefault [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"When no Unix-specific combination is set, combinationForUnix returns the default combination"
	| entry defaultCombination |
	entry := self entryWithDefaultCombination.
	defaultCombination := entry combination.
	
	self assert: entry rawCombinationForUnix isNil.
	self assert: entry combinationForUnix equals: defaultCombination.
	
	^ entry
]

{ #category : #'examples - platform fallback' }
BlRegistryKeymapEntryExamples >> combinationForWindowsFallsBackToDefault [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"When no Windows-specific combination is set, combinationForWindows returns the default combination"
	| entry defaultCombination |
	entry := self entryWithDefaultCombination.
	defaultCombination := entry combination.
	
	self assert: entry rawCombinationForWindows isNil.
	self assert: entry combinationForWindows equals: defaultCombination.
	
	^ entry
]

{ #category : #'examples - platform override' }
BlRegistryKeymapEntryExamples >> entryWithAllPlatformOverrides [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"Setting all platform-specific combinations"
	| entry defaultCombination macOsCombination windowsCombination unixCombination |
	entry := self entryWithDefaultCombination.
	defaultCombination := entry combination.
	
	macOsCombination := BlKeyCombination builder alt a build.
	windowsCombination := BlKeyCombination builder control b build.
	unixCombination := BlKeyCombination builder shift c build.
	
	entry combinationForMacOS: macOsCombination.
	entry combinationForWindows: windowsCombination.
	entry combinationForUnix: unixCombination.
	
	self assert: entry combination equals: defaultCombination.
	self assert: entry combinationForMacOS equals: macOsCombination.
	self assert: entry combinationForWindows equals: windowsCombination.
	self assert: entry combinationForUnix equals: unixCombination.
	
	^ entry
]

{ #category : #examples }
BlRegistryKeymapEntryExamples >> entryWithDefaultCombination [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	| entry shortcutId defaultCombination |
	entry := self basicEntry.
	
	shortcutId := BlShortcutId identifier: #TestShortcut.
	defaultCombination := BlKeyCombination builder primary a build.
	
	entry shortcutId: shortcutId.
	entry combination: defaultCombination.
	
	self assert: entry shortcutId equals: shortcutId.
	self assert: entry combination equals: defaultCombination.
	self assert: entry label equals: 'TestShortcut'.
	
	^ entry
]

{ #category : #'examples - platform override' }
BlRegistryKeymapEntryExamples >> entryWithMacOSOverride [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"Setting a macOS combination overrides the fallback for macOS only"
	| entry macOsCombination defaultCombination |
	entry := self entryWithDefaultCombination.
	defaultCombination := entry combination.
	
	macOsCombination := BlKeyCombination builder alt b build.
	entry combinationForMacOS: macOsCombination.
	
	self assert: entry rawCombinationForMacOS equals: macOsCombination.
	self assert: entry combinationForMacOS equals: macOsCombination.
	self assert: entry combinationForWindows equals: defaultCombination.
	self assert: entry combinationForUnix equals: defaultCombination.
	
	^ entry
]

{ #category : #'examples - platform override' }
BlRegistryKeymapEntryExamples >> entryWithUnixOverride [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"Setting a Unix combination overrides the fallback for Unix only"
	| entry unixCombination defaultCombination |
	entry := self entryWithDefaultCombination.
	defaultCombination := entry combination.
	
	unixCombination := BlKeyCombination builder shift d build.
	entry combinationForUnix: unixCombination.
	
	self assert: entry rawCombinationForUnix equals: unixCombination.
	self assert: entry combinationForUnix equals: unixCombination.
	self assert: entry combinationForMacOS equals: defaultCombination.
	self assert: entry combinationForWindows equals: defaultCombination.
	
	^ entry
]

{ #category : #'examples - platform override' }
BlRegistryKeymapEntryExamples >> entryWithWindowsOverride [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"Setting a Windows combination overrides the fallback for Windows only"
	| entry windowsCombination defaultCombination |
	entry := self entryWithDefaultCombination.
	defaultCombination := entry combination.
	
	windowsCombination := BlKeyCombination builder control c build.
	entry combinationForWindows: windowsCombination.
	
	self assert: entry rawCombinationForWindows equals: windowsCombination.
	self assert: entry combinationForWindows equals: windowsCombination.
	self assert: entry combinationForMacOS equals: defaultCombination.
	self assert: entry combinationForUnix equals: defaultCombination.
	
	^ entry
]

{ #category : #'examples - update' }
BlRegistryKeymapEntryExamples >> updateDefaultCombination [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"Updating the default combination changes what platforms without overrides resolve to"
	| entry newCombination |
	entry := self entryWithDefaultCombination.
	
	newCombination := BlKeyCombination escape.
	entry combination: newCombination.
	
	self assert: entry combination equals: newCombination.
	self assert: entry combinationForMacOS equals: newCombination.
	self assert: entry combinationForWindows equals: newCombination.
	self assert: entry combinationForUnix equals: newCombination.
	
	^ entry
]

{ #category : #'examples - update' }
BlRegistryKeymapEntryExamples >> updateDefaultCombinationDoesNotAffectOverrides [
	<gtExample>
	<return: #BlRegistryKeymapEntry>
	"Updating the default combination does not affect explicitly set platform overrides"
	| entry macOsCombination newDefault |
	entry := self entryWithMacOSOverride.
	macOsCombination := entry combinationForMacOS.
	
	newDefault := BlKeyCombination builder primary r build.
	entry combination: newDefault.
	
	self assert: entry combination equals: newDefault.
	self assert: entry combinationForMacOS equals: macOsCombination.
	self assert: entry combinationForWindows equals: newDefault.
	self assert: entry combinationForUnix equals: newDefault.
	
	^ entry
]
