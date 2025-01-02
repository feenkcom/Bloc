Extension { #name : #BlShortcutHandlerWithShortcuts }

{ #category : #'*Bloc-Extensions' }
BlShortcutHandlerWithShortcuts >> gtShortcutRegistryFor: aView [
	<gtView>
	^ aView forward
		title: 'Shortcut Registry';
		object: [ shortcutRegistry ];
		view: #gtItemsFor:
]
