Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.9.29/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:1ec64c67ca04a00e9a0c791fe064b6f451b1b422/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.232/src' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.128/src' ].

		spec package: 'Bloc-Text-Examples' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Layout-Examples' with: [
			spec requires: #(#Bloc #GToolkitExamplesEngine) ].
		spec package: 'Bloc-Examples' with: [
			spec requires: #(#Bloc) ].
		spec package: 'Bloc-Compositor-Examples' with: [
			spec requires: #(#Bloc #'Bloc-Examples') ].
		spec package: 'Bloc-Docs' with: [
			spec requires: #(#Bloc) ].
	]
]
