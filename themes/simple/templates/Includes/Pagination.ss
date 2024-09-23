<style>
    @media (max-width: 770px) {
        .toleft{
            left: 0 !important;
        }
    }
</style>   
   

<% with  $Result %>
<nav class="blog-pagination justify-content-center d-flex toleft" style="bottom: -10rem; position:absolute; left: 50%;">
    <% if $MoreThanOnePage %>
        <ul class="pagination">
            <% if $NotFirstPage %>
                <li class="page-item">
                    <a href="#" class="page-link" aria-label="Previous">
                        <span aria-hidden="true">
                            <span class="lnr lnr-chevron-left"></span>
                        </span>
                    </a>
                </li>
            <% end_if %>
            <% loop $PaginationSummary(10) %>
            <li class="page-item " style="list-style-type: none; ">
                <% if $Link %>
                    <a class="page-link "
                       href="$Link">$PageNum</a>
                <% else %>
                    <span class="bg-secondary ">...</span>
                <% end_if %>
            </li>
        <% end_loop %>

            <% if $NotLastPage %>
                <li class="page-item">
                    <a href="#" class="page-link" aria-label="Next">
                        <span aria-hidden="true">
                            <span class="lnr lnr-chevron-right"></span>
                        </span>
                    </a>
                </li>
            <% end_if %>
        </ul>
    <% end_if %>
</nav>
<% end_with %>