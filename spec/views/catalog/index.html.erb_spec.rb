require 'spec_helper'

describe "catalog/index.html.erb" do
  it "should render the sidebar and content panes" do
    allow(view).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
    render
    expect(rendered).to match /id="sidebar"/
    expect(rendered).to match /id="content"/
  end

  it "should render the search_sidebar partial " do
    stub_template "catalog/_search_sidebar.html.erb" => "sidebar_content"

    allow(view).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
    render
    expect(rendered).to match /sidebar_content/
  end

  it "should render the search_header partial " do
    stub_template "catalog/_results_pagination.html.erb" => ""
    stub_template "catalog/_search_header.html.erb" => "header_content"

    allow(view).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
    allow(view).to receive(:has_search_parameters?).and_return(true)
    allow(view).to receive(:extra_head_content).and_return([])
    allow(view).to receive(:render_opensearch_response_metadata).and_return("")
    assign(:response, double(:empty? => true))
    render
    expect(rendered).to match /header_content/
  end
end