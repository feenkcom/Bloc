"
I contain examples for BlSpaceKeymapRegistry verifying that all space-level keyboard shortcuts are properly registered.
"
Class {
	#name : #BlSpaceKeymapRegistryExamples,
	#superclass : #Object,
	#category : #'Bloc-Tests-KeyBinding'
}

{ #category : #examples }
BlSpaceKeymapRegistryExamples >> allEntriesHaveShortcutId [
	<gtExample>
	<return: #BlSpaceKeymapRegistry>
	"Verifies that every entry in the space registry has its shortcutId set"
	| registry |
	registry := self spaceKeymapRegistry.
	registry keymapsById keysAndValuesDo: [ :shortcutId :entry |
		self assert: entry shortcutId notNil.
		self assert: entry shortcutId equals: shortcutId ].
	^ registry
]

{ #category : #examples }
BlSpaceKeymapRegistryExamples >> extensionShortcutsPresent [
	<gtExample>
	<return: #BlSpaceKeymapRegistry>
	"Verifies that extension shortcuts from GToolkit-World are registered"
	| registry |
	registry := self spaceKeymapRegistry.
	self assert: (registry hasCombinationFor: BlSpaceShortcutIds default openSpotterShortcutId).
	self assert: (registry hasCombinationFor: BlSpaceShortcutIds default openGlobalMenuShortcutId).
	self assert: (registry hasCombinationFor: BlSpaceShortcutIds default selectPreviousTabShortcutId).
	self assert: (registry hasCombinationFor: BlSpaceShortcutIds default selectNextTabShortcutId).
	self assert: (registry hasCombinationFor: BlSpaceShortcutIds default closeTabShortcutId).
	self assert: (registry hasCombinationFor: BlSpaceShortcutIds default closeWorldShortcutId).
	self assert: (registry hasCombinationFor: BlSpaceShortcutIds default openPreviewerShortcutId).
	^ registry
]

{ #category : #examples }
BlSpaceKeymapRegistryExamples >> fullRegistryHasElevenEntries [
	<gtExample>
	<return: #BlSpaceKeymapRegistry>
	"Verifies that the registry has all 11 shortcuts (4 core + 7 extensions)"
	| registry |
	registry := self spaceKeymapRegistry.
	self assert: registry numberOfKeymaps equals: 11.
	^ registry
]

{ #category : #examples }
BlSpaceKeymapRegistryExamples >> registryDiscoveredByGlobalRegistry [
	<gtExample>
	<return: #BlSpaceKeymapRegistry>
	"Verifies that the space registry is discovered by the global BlShortcutKeymapRegistry"
	| globalRegistry spaceRegistry |
	globalRegistry := BlShortcutKeymapRegistry default.
	spaceRegistry := globalRegistry space.
	self assert: spaceRegistry notNil.
	self assert: spaceRegistry class equals: BlSpaceKeymapRegistry.
	^ spaceRegistry
]

{ #category : #examples }
BlSpaceKeymapRegistryExamples >> shortcutResolvesFromSpaceRegistry [
	<gtExample>
	<return: #BlShortcutWithAction>
	"Verifies that a BlShortcutWithAction with spaceShortcutId: resolves its combination from the registry"
	| shortcut |
	shortcut := BlShortcutWithAction new
		name: 'Zoom in';
		spaceShortcutId: BlSpaceShortcutIds default zoomInShortcutId.
	self assert: shortcut shortcutId notNil.
	self assert: shortcut combination notNil.
	self assert: shortcut combinationForPlatform notNil.
	^ shortcut
]

{ #category : #examples }
BlSpaceKeymapRegistryExamples >> spaceKeymapRegistry [
	<gtExample>
	<return: #BlSpaceKeymapRegistry>
	| registry |
	registry := BlSpaceKeymapRegistry new.
	self assert: registry numberOfKeymaps >= 4.
	^ registry
]
