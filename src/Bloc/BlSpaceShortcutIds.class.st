"
I hold the shortcut identifiers for space-level keyboard shortcuts. Core shortcuts (zoom in/out/normal, screenshot) are stored as instance variables. Shortcuts from other packages (GToolkit-World, GToolkit-WorldPreviewer) are stored via the extensible extraShortcutIdsByIdentifier mechanism inherited from BlShortcutIds, accessed via shortcutIdForIdentifier:.
"
Class {
	#name : #BlSpaceShortcutIds,
	#superclass : #BlShortcutIds,
	#instVars : [
		'zoomInShortcutId',
		'zoomOutShortcutId',
		'zoomNormalShortcutId',
		'takeScreenshotShortcutId'
	],
	#category : #'Bloc-Space - Task Queue'
}

{ #category : #initialization }
BlSpaceShortcutIds >> initialize [
	super initialize.
	
	zoomInShortcutId := BlShortcutId identifier: #SpaceZoomIn.
	zoomOutShortcutId := BlShortcutId identifier: #SpaceZoomOut.
	zoomNormalShortcutId := BlShortcutId identifier: #SpaceZoomNormal.
	takeScreenshotShortcutId := BlShortcutId identifier: #SpaceTakeScreenshot
]

{ #category : #accessing }
BlSpaceShortcutIds >> takeScreenshotShortcutId [
	^ takeScreenshotShortcutId
]

{ #category : #accessing }
BlSpaceShortcutIds >> zoomInShortcutId [
	^ zoomInShortcutId
]

{ #category : #accessing }
BlSpaceShortcutIds >> zoomNormalShortcutId [
	^ zoomNormalShortcutId
]

{ #category : #accessing }
BlSpaceShortcutIds >> zoomOutShortcutId [
	^ zoomOutShortcutId
]
