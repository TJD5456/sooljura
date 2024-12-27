<%@ page contentType="text/html;charset=UTF-8" %>
<div class="youtube">
    <iframe width="560" height="315" src="${youtube.youtubeUrl}"
            title="YouTube video player" frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
    </iframe>

    <div class="text">
        <div class="youtube-content">
            ${youtube.content}
        </div>

        <div class="related-products">
            ${youtube.prodKey1}
            <c:if test="${youtube.prodKey2 != null}">
                ${youtube.prodKey2}
            </c:if>
            <c:if test="${youtube.prodKey3 != null}">
                ${youtube.prodKey3}
            </c:if>
        </div>
    </div>
</div>
