Extension { #name : #BlElementTheme }

{ #category : #'*Bloc-Extensions' }
BlElementTheme >> gtThemeFor: aView [
	<gtView>
	^ aView forward
		title: 'Theme';
		object: [ self theme ];
		view: #gtThemeFor:
]
