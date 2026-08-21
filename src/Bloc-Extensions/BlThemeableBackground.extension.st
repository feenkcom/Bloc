Extension { #name : #BlThemeableBackground }

{ #category : #'*Bloc-Extensions' }
BlThemeableBackground >> gtViewBackgroundFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 50;
		stencil: [
			BlElement new
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				padding: (BlInsets all: 50);
				addChild:(BlElement new
					size: 200@100;
					outskirts: (BlOutskirts inside);
					theme: theme;
					background: self) ]
]
