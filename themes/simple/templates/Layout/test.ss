<ul class="main-categories">
    <% if $Category %>
        <% loop $Category %>
            <li class="main-nav-list">
                <a data-toggle="collapse" data-target="#collapseExample-$ID" aria-expanded="false" aria-controls="collapseExample" href="#">
                    <span class="lnr lnr-arrow-right"></span>$Title <span class="number">($ProductSubCategory.Count)</span>
                </a>
                <ul class="collapse" id="collapseExample-$ID" data-toggle="collapse" aria-expanded="false" aria-controls="category-$ID">
                    <% if $ProductSubCategory %>
                        <% loop $ProductSubCategory %>
                            <li class="main-nav-list child">
                                <a href="#" data-id="$ID" class="subcategory-link">$Title <span class="number">($ProductObject.Count)</span></a>
                            </li>
                        <% end_loop %>
                    <% else %>
                        <li class="main-nav-list child py-2">This SubCategory is Coming Soon</li>
                    <% end_if %>
                </ul>
            </li>
        <% end_loop %>
    <% else %>
        <li class="main-nav-list child py-2">This Category is Coming Soon</li>  
    <% end_if %>
           </ul>