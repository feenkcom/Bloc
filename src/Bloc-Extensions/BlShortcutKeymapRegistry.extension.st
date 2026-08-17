Extension { #name : #BlShortcutKeymapRegistry }

{ #category : #'*Bloc-Extensions' }
BlShortcutKeymapRegistry >> gtResetActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons refresh;
		tooltip: 'Reset registry';
		priority: 1;
		action: [ :aButton | 
			self reset.
			aButton phlow fireToolUpdateWish ]
]
