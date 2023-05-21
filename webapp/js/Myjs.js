
//liking posts
function doLike(pId, uId) {
	console.log(pId + "," + uId)
	const d = {
		uId: uId,
		pId: pId,
		operation: 'like'
	}

	$.ajax({
		url: "LikeServlet",
		data: d,
		type: "post",
		success: function(data, textStatus, jqXHR) {
			console.log(data);
			if (data.trim() == 'like') {
				let c = $(".like-counter").html();
				c++;
				$(".like-counter").html(c);
			}
			if (data.trim() == 'delete') {
				let c = $(".like-counter").html();
				c--;
				$(".like-counter").html(c);
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(data)
		}
	})
}

