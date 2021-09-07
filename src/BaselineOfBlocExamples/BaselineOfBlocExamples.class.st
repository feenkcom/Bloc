Class {
	#name : 'BaselineOfBlocExamples',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBlocExamples'
}

{ #category : 'baseline' }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.235/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:a119e739bc378ca2a95883e074090d90fed4edeb/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.69/src' ].
		spec
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:be8fa748709d46db980441af0f9946f3ac89ae33' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.33/src' ].

		spec package: 'Bloc-Text-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Layout-Examples' with: [
			spec requires: #('Bloc' 'GToolkitExamplesEngine') ].
		spec package: 'Bloc-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Compositor-Examples' with: [
			spec requires: #('Bloc' #'Bloc-Examples') ].
		spec package: 'Bloc-Docs' with: [
			spec requires: #('Bloc') ].
	]
]
