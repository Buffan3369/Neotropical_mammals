#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 10 10:42:28 2024

@authors: ChatGPT
"""
import os
from serpapi import GoogleSearch
import bibtexparser

os.chdir("/home/lucas.buffan/Documents/GitHub/PhD/Chapter_1/")


# Function to get DOI and URL using SerpApi
def get_url_and_doi(reference_title, api_key):
    params = {
        "engine": "google_scholar",
        "q": reference_title,
        "api_key": api_key
    }

    search = GoogleSearch(params)
    results = search.get_dict()

    if 'organic_results' in results:
        first_result = results['organic_results'][0]
        url = first_result.get('link', None)
        doi = None
        for citation in first_result.get('citation', []):
            if citation.startswith('DOI:'):
                doi = citation.replace('DOI:', '').strip()
                break
        return url, doi
    return None, None

# Function to filter and update references
def filter_and_update_references(input_file, output_file, api_key):
    # Load the .bib file
    with open(input_file, 'r') as bibtex_file:
        bib_database = bibtexparser.load(bibtex_file)

    # Loop through each entry and update if missing URL or DOI
    for entry in bib_database.entries:
        if 'doi' not in entry and 'url' not in entry:
            title = entry.get('title', '')
            if title:
                url, doi = get_url_and_doi(title, api_key)
                if url:
                    entry['url'] = url
                if doi:
                    entry['doi'] = doi

    # Save the updated entries to a new .bib file
    with open(output_file, 'w') as bibtex_file:
        bibtexparser.dump(bib_database, bibtex_file)

# Example usage
input_bib_file = './manuscript/Supp_Mat/Supp_refs.bib'  # Replace with your input .bib file
output_bib_file = './manuscript/Supp_Mat/Updated_refs.bib'  # Output file with updated references
serpapi_api_key = '84d689b3dbb9776997fc4c826f2cd39785b5bbd67c64799189bfac70740891be'  # Replace with your SerpApi API key

filter_and_update_references(input_bib_file, output_bib_file, serpapi_api_key)

