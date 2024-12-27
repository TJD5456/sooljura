<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f9f9f9;
    }

    .youtube {
        display: flex;
        border: 1px solid #ddd;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin: 20px auto;
        padding: 16px;
        max-width: 800px;
    }

    .youtube iframe {
        flex: 1 1 60%;
        border: none;
        border-radius: 8px;
        margin-right: 16px;
    }

    .text {
        flex: 1 1 40%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 8px 16px;
    }

    .youtube-content {
        margin-bottom: 16px;
        font-size: 1.1em;
        color: #333;
    }

    .related-products {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        font-size: 0.9em;
        color: #555;
    }

    .related-products div {
        background: #f1f1f1;
        padding: 8px 12px;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
</style>

<div class="youtube">
    <iframe width="560" height="315" src="${youtube.youtubeUrl}"
            title="YouTube video player"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
    </iframe>

    <div class="text">
        <div class="youtube-content">
            ${youtube.content}
        </div>

        <div class="related-products">
            <div><img src="/resources/upload/product_images/${prod1.imgPath}" alt="${prod1.imgNm}"></div>
            <c:if test="${youtube.prodKey2 != null}">
                <div><img src="/resources/upload/product_images/${prod2.imgPath}" alt="${prod2.imgNm}"></div>
            </c:if>
            <c:if test="${youtube.prodKey3 != null}">
                <div><img src="/resources/upload/product_images/${prod3.imgPath}" alt="${prod3.imgNm}"></div>
            </c:if>
        </div>
    </div>
</div>
