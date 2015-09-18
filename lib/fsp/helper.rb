module FSP
  module Helper
    # Returns a link which sorts by the given sort spec.
    #
    # - spec is the specification of a column in the sorted record collection.  See FSP::Sorter
    # - The optional caption explicitly specifies the displayed link text.
    # - A sort icon image is positioned to the left of the sort caption.
    def sort_link(fsp, spec, options = {})
      spec = spec.to_s
      fsp_new = fsp.dup.change_sort(spec)
      icon = image_path(fsp_new.sort_icon(fsp.sorter.first))
      caption = options.delete(:caption) || spec.humanize
      html_options = {:title => fsp_new.sort_description(caption)}
      link_to(image_tag(icon, :class => 'fs_sort') + '&nbsp;' + caption, self.send(fsp_new.url_writer, fsp_new.get_params), html_options)
    end

    # Returns a table header <th> tag with a sort link for the given sort spec.
    #
    # Options:
    #   :caption     The displayed link name (defaults to titleized spec).
    #   :title       The tag's 'title' attribute (defaults to 'Sort by :caption').
    #
    # Other options hash entries generate additional table header tag attributes.
    #
    # Example:
    #
    #   <%= sort_header_tag('id', :title => 'Sort by contact ID', :width => 40) %>
    #
    # Renders:
    #
    #   <th title="Sort by contact ID" width="40">
    #     <a href="/contact/list?sort_order=desc&amp;sort_key=id">Id</a>
    #     &nbsp;&nbsp;<img alt="Sort_asc" src="/images/sort_asc.png" />
    #   </th>
    def sort_header_tag(fsp, spec, options = {})
      content_tag('th', sort_link(fsp, spec, options))
    end

    # Returns a graphical link which toggles the filter.
    # - A dynamic title will be generated if a static one is not supplied.
    # - The filter icon images are derived from the fsp.name attribute, or a
    #   default set if not found.
    def filter_toggle_link(fsp, options = {})
      fsp_new = fsp.dup.next_filter
      icon = image_path(fsp.filter_icon)
      html_options = {:title => options[:title] || fsp_new.filter_description}
      link_to(image_tag(icon, :id => 'fs_toggle'), self.send(fsp_new.url_writer, fsp_new.get_params), html_options)
    end
  end
end